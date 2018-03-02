local assets=
{
    Asset("ANIM", "anim/ostuxlaser.zip"),
    Asset("ANIM", "anim/swap_ostuxlaser.zip"),

    Asset("ATLAS", "images/inventoryimages/ostuxlaser.xml"),
    Asset("IMAGE", "images/inventoryimages/ostuxlaser.tex"),
}

--Stole Life
local function onattack(inst, owner, target)
	owner.components.health:DoDelta(5)
end


local function onfinished(inst)
    inst:Remove()
end

local function changeLight(inst)
    inst.Light:Enable(false)

    --check the sword is in the inventory or is in the hand
    -- also check is in the cave and or is night
    if inst.components.equippable:IsEquipped() then
        if GetWorld():IsCave() then
            inst.Light:Enable(true)
        end
        if GetClock():IsNight() then
            inst.Light:Enable(true)
        end
    end
end

local function onpocket(inst, owner)
    inst.Light:Enable(false)
end

local function onequip(inst, owner)
 	owner.AnimState:OverrideSymbol("swap_object", "swap_ostuxlaser", "ostuxlaser")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")

    --check the sword is in the backpack or in the main inventory
    inst.components.inventoryitem.onputininventoryfn = function(inst, inv)
        if inv.components.inventory then
            changeLight(inst)
        end
        if inv.components.container then
            inst.Light:Enable(false)
        end
    end
    changeLight(inst)
end

local function onunequip(inst, owner)
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")

    inst.Light:Enable(false)
end

local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)

    anim:SetBank("ostuxlaser")
    anim:SetBuild("ostuxlaser")
    anim:PlayAnimation("idle")

	inst:AddTag("sharp")

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.LASER_DAMAGE)
    inst.components.weapon:SetOnAttack( onattack)

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.LASER_MAXUSES)
    inst.components.finiteuses:SetUses(TUNING.LASER_MAXUSES)
    inst.components.finiteuses:SetOnFinished( onfinished)

    inst:AddTag("light")
    inst.entity:AddLight()
	inst.Light:SetRadius(TUNING.LASER_LIGHT_RADIUS)
    inst.Light:SetFalloff(1)
    inst.Light:SetIntensity(.7)
    inst.Light:SetColour(180/255, 195/255, 150/255)
	inst.Light:Enable(false)
	inst.Light:SetDisableOnSceneRemoval(false)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ostuxlaser"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ostuxlaser.xml"

    inst:AddComponent("equippable")
	inst.components.equippable:SetOnPocket( onpocket )
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )

	inst:ListenForEvent("ondropped", function(inst)
		inst.Light:Enable(false)
	end)

    inst:ListenForEvent("daytime", function() changeLight(inst) end, GetWorld())
    inst:ListenForEvent("nighttime", function() changeLight(inst) end, GetWorld())

    return inst
end

return  Prefab("common/inventory/ostuxlaser", fn, assets)

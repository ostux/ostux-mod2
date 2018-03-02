local assets=
{
    Asset("ANIM", "anim/ostuxkatana.zip"),
    Asset("ANIM", "anim/swap_ostuxkatana.zip"),

    Asset("ATLAS", "images/inventoryimages/ostuxkatana.xml"),
    Asset("IMAGE", "images/inventoryimages/ostuxkatana.tex"),
}

--Stole Life
local function onattack(inst, owner, target)
	owner.components.health:DoDelta(5)
end

local function onfinished(inst)
    inst:Remove()
end

local function fn(Sim)

    local function OnEquip(inst, owner)
        owner.AnimState:OverrideSymbol("swap_object", "swap_ostuxkatana", "ostuxkatana")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
    end

    local function OnUnequip(inst, owner)
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
    end

    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local sound = inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)

    anim:SetBank("ostuxkatana")
    anim:SetBuild("ostuxkatana")
    anim:PlayAnimation("idle")

	inst:AddTag("sharp")

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.KATANA_DAMAGE)
    inst.components.weapon:SetOnAttack( onattack)

    -------
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.KATANA_MAXUSES)
    inst.components.finiteuses:SetUses(TUNING.KATANA_MAXUSES)
    inst.components.finiteuses:SetOnFinished( onfinished)
    -------

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ostuxkatana"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ostuxkatana.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )

    return inst
end

return  Prefab("common/inventory/ostuxkatana", fn, assets)

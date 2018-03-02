local assets=
{
    Asset("ANIM", "anim/ostuxarmor.zip"),

    Asset("ATLAS", "images/inventoryimages/ostuxarmor.xml"),
    Asset("IMAGE", "images/inventoryimages/ostuxarmor.tex"),
}

local function onfinished(inst)
    inst:Remove()
end

local function OnBlocked(owner)
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_body", "ostuxarmor", "swap_body")
    inst:ListenForEvent("blocked", OnBlocked, owner)

    local owner = inst.components.inventoryitem.owner
    if owner then
        local hunger = owner.components.hunger
        if hunger then
            hunger:SetRate(TUNING.OSTUXARMOR_HUNGER*TUNING.WILSON_HUNGER_RATE)
        end
    end
end

local function onunequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_body")

    inst:RemoveEventCallback("blocked", OnBlocked, owner)

    local owner = inst.components.inventoryitem.owner
    if owner then
        local hunger = owner.components.hunger
        if hunger then
            hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
        end
    end
end

local function fn(Sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("armor_wood")
    inst.AnimState:SetBuild("ostuxarmor")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("grass")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ostuxarmor.xml"
    inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/grassarmour"

    inst:AddComponent("dapperness")
    inst.components.dapperness.dapperness = TUNING.OSTUXARMOR_SANITY

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    inst:AddComponent("armor")
    inst.components.armor:InitCondition(TUNING.OSTUXARMOR, TUNING.OSTUXARMOR_ABSORPTION)

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable.walkspeedmult = TUNING.OSTUXARMOR_SPEEDMULTI

    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )

    return inst
end

return Prefab( "common/inventory/ostuxarmor", fn, assets)

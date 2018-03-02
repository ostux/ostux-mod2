local assets=
{
	Asset("ANIM", "anim/ostuxbackpack.zip"),
	Asset("ANIM", "anim/swap_ostuxbackpack.zip"),

	Asset("ATLAS", "images/inventoryimages/ostuxbackpack.xml"),
    Asset("IMAGE", "images/inventoryimages/ostuxbackpack.tex"),
}

local function OnBlocked(owner)
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_body", "swap_ostuxbackpack", "backpack1")
    owner.AnimState:OverrideSymbol("swap_body", "swap_ostuxbackpack", "swap_body")

    owner.components.inventory.overflow = inst
    inst.components.container:Open(owner)
end

local function onunequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_body")
    owner.AnimState:ClearOverrideSymbol("backpack1")
    owner.components.inventory.overflow = nil
    inst.components.container:Close(owner)
end


local function onopen(inst)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_open", "open")
end

local function onclose(inst)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_close", "open")
end


local slotpos = {}

for y = 0, 6 do
	table.insert(slotpos, Vector3(-162, -y*75 + 240 ,0))
	table.insert(slotpos, Vector3(-162 +75, -y*75 + 240 ,0))
  --162
end

local function fn(Sim)
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("backpack1")
    inst.AnimState:SetBuild("ostuxbackpack")
    inst.AnimState:PlayAnimation("anim")

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("backpack.png")

	inst:AddComponent("inventoryitem")
  	inst.components.inventoryitem.atlasname = "images/inventoryimages/ostuxbackpack.xml"
    inst.components.inventoryitem.cangoincontainer = false
    inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/backpack"

    inst:AddComponent("equippable")
    if EQUIPSLOTS["BACK"] then
      	inst.components.equippable.equipslot = EQUIPSLOTS.BACK
    else
       	inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    end

    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )

   	inst:AddComponent("inspectable")

    inst:AddComponent("container")
    inst.components.container:SetNumSlots(#slotpos)
    inst.components.container.widgetslotpos = slotpos
    inst.components.container.widgetanimbank = "ui_krampusbag_2x8"
    inst.components.container.widgetanimbuild = "ui_krampusbag_2x8"
    inst.components.container.widgetpos = Vector3(-5,-50,0)
   	inst.components.container.side_widget = true
    inst.components.container.type = "pack"

    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

    return inst
end

return  Prefab("common/inventory/ostuxbackpack", fn, assets)

local Easy = (GetModConfigData("Mode")=="easy")
local Normal = (GetModConfigData("Mode")=="normal")
local Hard = (GetModConfigData("Mode")=="hard")

local MoreItemOff = (GetModConfigData("MoreItem")=="off")
local MoreItemOn = (GetModConfigData("MoreItem")=="on")

local StackableRabitOff = (GetModConfigData("StackableItems")=="off")
local StackableRabitOn = (GetModConfigData("StackableItems")=="on")

local ExtremModeOff = (GetModConfigData("ExtremMode")=="off")
local ExtremModeOn = (GetModConfigData("ExtremMode")=="on")

function makestackablePrefabPostInit(inst)

	inst:AddComponent("stackable")
		inst.components.stackable.maxsize = 20

end

if MoreItemOn then
	TUNING.STACK_SIZE_LARGEITEM = 33
	TUNING.STACK_SIZE_MEDITEM = 66
	TUNING.STACK_SIZE_SMALLITEM = 99
end

if ExtremModeOn then
	TUNING.LASER_DAMAGE = TUNING.SPEAR_DAMAGE * 4
	TUNING.LASER_LIGHT_RADIUS = 6.8
	TUNING.LASER_MAXUSES = 2000

	TUNING.KATANA_DAMAGE = TUNING.SPEAR_DAMAGE * 9
	TUNING.KATANA_MAXUSES = 2000

	TUNING.OSTUXARMOR = 8000
	TUNING.OSTUXARMOR_ABSORPTION = .95
	TUNING.OSTUXARMOR_SPEEDMULTI = 1.6
	TUNING.OSTUXARMOR_SANITY = TUNING.CRAZINESS_SMALL * -1
	TUNING.OSTUXARMOR_HUNGER = 1
end
if ExtremModeOff then
	TUNING.LASER_DAMAGE = TUNING.SPEAR_DAMAGE * 1.5
	TUNING.LASER_LIGHT_RADIUS = 3.7
	TUNING.LASER_MAXUSES = 120

	TUNING.KATANA_DAMAGE = TUNING.SPEAR_DAMAGE * 1.7
	TUNING.KATANA_MAXUSES = 140

	TUNING.OSTUXARMOR = 450
	TUNING.OSTUXARMOR_ABSORPTION = .25
	TUNING.OSTUXARMOR_SPEEDMULTI = 1.45
	TUNING.OSTUXARMOR_SANITY = TUNING.CRAZINESS_SMALL * .5
	TUNING.OSTUXARMOR_HUNGER = 1.3
end


if StackableRabitOn then
	AddPrefabPostInit("crow", makestackablePrefabPostInit)
	AddPrefabPostInit("rabbit", makestackablePrefabPostInit)
	AddPrefabPostInit("robin", makestackablePrefabPostInit)
	AddPrefabPostInit("robin_winter", makestackablePrefabPostInit)
	AddPrefabPostInit("crab", makestackablePrefabPostInit)
	AddPrefabPostInit("parrot", makestackablePrefabPostInit)
	AddPrefabPostInit("seagull", makestackablePrefabPostInit)
	AddPrefabPostInit("toucan", makestackablePrefabPostInit)
	AddPrefabPostInit("crab", makestackablePrefabPostInit)
	AddPrefabPostInit("jellyfish", makestackablePrefabPostInit)
	AddPrefabPostInit("snakeoil", makestackablePrefabPostInit)
	AddPrefabPostInit("coral_brain", makestackablePrefabPostInit)
	AddPrefabPostInit("lobster", makestackablePrefabPostInit)
	AddPrefabPostInit("heatrock", makestackablePrefabPostInit)
end

STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH

GLOBAL.STRINGS.NAMES.OSTUXKATANA = "OsTux Katana"
STRINGS.RECIPE_DESC.OSTUXKATANA = "Katana with life steal benefit."

GLOBAL.STRINGS.NAMES.OSTUXLASER = "OsTux Laser Sword"
STRINGS.RECIPE_DESC.OSTUXLASER = "Laser sword with life steal and lighting benefit."

GLOBAL.STRINGS.NAMES.OSTUXBACKPACK = "OsTux's BackPack"
STRINGS.RECIPE_DESC.OSTUXBACKPACK = "A backpack, fit for a Hero."

GLOBAL.STRINGS.NAMES.OSTUXARMOR = "OsTux's Flash Suit"
STRINGS.RECIPE_DESC.OSTUXARMOR = "Speed up for the light..."

Assets =
{
	Asset("ATLAS", "images/inventoryimages/ostuxkatana.xml"),
	Asset("ATLAS", "images/inventoryimages/ostuxlaser.xml"),
	Asset("ATLAS", "images/inventoryimages/ostuxbackpack.xml"),
	Asset("ATLAS", "images/inventoryimages/ostuxarmor.xml"),
}

PrefabFiles = {
	"ostuxkatana",
	"ostuxlaser",
	"ostuxbackpack",
	"ostuxarmor",
}

 if Easy then
		local ostuxkatanaRecipe = GLOBAL.Recipe( "ostuxkatana",
				{
					Ingredient("flint", 10),
					Ingredient("cutgrass", 20),
					Ingredient("charcoal", 10)
				},

				RECIPETABS.WAR, TECH.NONE)
				ostuxkatanaRecipe.atlas = "images/inventoryimages/ostuxkatana.xml"

		local ostuxlaserRecipe = GLOBAL.Recipe( "ostuxlaser",
				{
					Ingredient("goldnugget", 5),
					Ingredient("flint", 5),
					Ingredient("spear", 1)
				},

				RECIPETABS.WAR, TECH.NONE)
				ostuxlaserRecipe.atlas = "images/inventoryimages/ostuxlaser.xml"

		local ostuxbackpackRecipe = GLOBAL.Recipe( "ostuxbackpack",
				{
					Ingredient("twigs", 5),
					Ingredient("cutgrass", 20)
				},

				RECIPETABS.SURVIVAL, TECH.NONE)
				ostuxbackpackRecipe.atlas = "images/inventoryimages/ostuxbackpack.xml"

		local ostuxarmorRecipe = GLOBAL.Recipe( "ostuxarmor",
				{
					Ingredient("spidergland", 5),
					Ingredient("cutgrass", 20),
					Ingredient("petals_evil", 3)
				},

				RECIPETABS.WAR, TECH.NONE)
				ostuxarmorRecipe.atlas = "images/inventoryimages/ostuxarmor.xml"
	else
	if Normal then
		local ostuxkatanaRecipe = GLOBAL.Recipe( "ostuxkatana",
				{
					Ingredient("goldnugget", 4),
					Ingredient("rope", 2),
					Ingredient("charcoal", 10)
				},

				RECIPETABS.WAR, TECH.SCIENCE_ONE)
				ostuxkatanaRecipe.atlas = "images/inventoryimages/ostuxkatana.xml"

		local ostuxlaserRecipe = GLOBAL.Recipe( "ostuxlaser",
				{
					Ingredient("redgem", 5),
					Ingredient("lightbulb", 5),
					Ingredient("tentaclespike", 1)
				},

				RECIPETABS.WAR, TECH.SCIENCE_ONE)
				ostuxlaserRecipe.atlas = "images/inventoryimages/ostuxlaser.xml"

		local ostuxbackpackRecipe = GLOBAL.Recipe( "ostuxbackpack",
				{
					Ingredient("nightmarefuel", 1),
					Ingredient("rope", 10),
					Ingredient("cutgrass", 20)
				},

				RECIPETABS.SURVIVAL, TECH.SCIENCE_ONE)
				ostuxbackpackRecipe.atlas = "images/inventoryimages/ostuxbackpack.xml"

		local ostuxarmorRecipe = GLOBAL.Recipe( "ostuxarmor",
				{
					Ingredient("pigskin", 4),
					Ingredient("redgem", 3),
					Ingredient("nightmarefuel", 3)
				},

				RECIPETABS.WAR, TECH.SCIENCE_ONE)
				ostuxarmorRecipe.atlas = "images/inventoryimages/ostuxarmor.xml"
	else
	if Hard then
		local ostuxkatanaRecipe = GLOBAL.Recipe( "ostuxkatana",
				{
					Ingredient("goldnugget", 7),
					Ingredient("nightmarefuel", 4),
					Ingredient("charcoal", 10)
				},

				RECIPETABS.WAR, TECH.SCIENCE_ONE)
				ostuxkatanaRecipe.atlas = "images/inventoryimages/ostuxkatana.xml"

		local ostuxlaserRecipe = GLOBAL.Recipe( "ostuxlaser",
				{
					Ingredient("purplegem", 1),
					Ingredient("thulecite_pieces", 3),
					Ingredient("firestaff", 1)
				},

				RECIPETABS.WAR, TECH.SCIENCE_TWO)
				ostuxlaserRecipe.atlas = "images/inventoryimages/ostuxlaser.xml"

		local ostuxbackpackRecipe = GLOBAL.Recipe( "ostuxbackpack",
				{
					Ingredient("boards", 7),
					Ingredient("rope", 5),
					Ingredient("livinglog", 3)
				},

				RECIPETABS.SURVIVAL, TECH.SCIENCE_TWO)
				ostuxbackpackRecipe.atlas = "images/inventoryimages/ostuxbackpack.xml"

		local ostuxarmorRecipe = GLOBAL.Recipe( "ostuxarmor",
				{
					Ingredient("pigskin", 4),
					Ingredient("purplegem", 1),
					Ingredient("thulecite_pieces", 3)
				},

				RECIPETABS.WAR, TECH.SCIENCE_TWO)
				ostuxarmorRecipe.atlas = "images/inventoryimages/ostuxarmor.xml"
    end
  end
end



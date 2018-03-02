name = "Ostux Mod 2"
description = "Katana, Laser sword, 14 slots Backpack and a Flash suit... What else you need?"
author = "Andras Toth"
version = "2.1"
forumthread = ""
api_version = 6

icon_atlas = "modicon.xml"
icon = "modicon.tex"

priority = 2.5
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true

configuration_options =
{
	{
		name = "Mode",
		label = "Difficulty",
		options =
	{
		{description = "Easy", data = "easy"},
		{description = "Normal", data = "normal"},
		{description = "Hard", data = "hard"},
	},
		default = "normal",
	},

	{
		name = "MoreItem",
		label = "More Items",
		options =
	{
		{description = "off (default)", data = "off"},
		{description = "on", data = "on"},
	},
		default = "off",
	},

	{
		name = "StackableItems",
		label = "Stackable items",
		options =
	{
		{description = "off (default)", data = "off"},
		{description = "on", data = "on"},
	},
		default = "off",
	},
	{
		name = "ExtremMode",
		label = "OP Mode",
		options =
	{
		{description = "off (default)", data = "off"},
		{description = "on", data = "on"},
	},
		default = "off",
	},
}

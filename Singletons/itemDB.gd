extends Node

const ICON_PATH = "res://Entita/Equipaggiabili/IconeUI/"

var weapons = [
	null,
	{
		"name" : "Sword",
		"mesh" : "res://Entita/Equipaggiabili/armi/Sword.tscn",
		"icon" : ICON_PATH + "Sword.png",
		"dmg" : 10,
		"atkspd" : 5
	},
	{
		"name" : "Iron Sword",
		"mesh" : "res://Entita/Equipaggiabili/armi/Sword.tscn",
		"icon" : ICON_PATH + "Iron Sword.png",
		"dmg" : 15,
		"atkspd" : 10
	},
	{
		"name" : "Steel Sword",
		"mesh" : "res://Entita/Equipaggiabili/armi/Sword.tscn",
		"icon" : ICON_PATH + "Steel Sword.png",
		"dmg" : 20,
		"atkspd" : 15
	}
]


var armors = [
	null,
	{
		"name" : "Cloth Cuirass",
		"mesh" : "res://Entita/Equipaggiabili/armi/Sword.tscn",
		"icon" : ICON_PATH + "Cloth Cuirass.png",
		"def" : 5
	},
	{
		"name" : "Iron Cuirass",
		"mesh" : "res://Entita/Equipaggiabili/armi/Sword.tscn",
		"icon" : ICON_PATH + "Iron Cuirass.png",
		"def" : 10
	},
	{
		"name" : "Steel Cuirass",
		"icon" : ICON_PATH + "Iron Cuirass.png",
		"def" : 15
	},
	{
		"name" : "Cloth Helmet",
		"icon" : ICON_PATH + "Cloth Helmet.png",
		"def" : 5
	},
	{
		"name" : "Iron Helmet",
		"icon" : ICON_PATH + "Iron Helmet.png",
		"def" : 10
	},
	{
		"name" : "Steel Helmet",
		"icon" : ICON_PATH + "Iron Helmet.png",
		"def" : 15
	},
	{
		"name" : "Cloth Bottom",
		"icon" : ICON_PATH + "Cloth Bottom.png",
		"def" : 5
	},
	{
		"name" : "Iron Bottom",
		"icon" : ICON_PATH + "Iron Bottom.png",
		"def" : 10
	},
	{
		"name" : "Steel Bottom",
		"icon" : ICON_PATH + "Iron Bottom.png",
		"def" : 15
	},
	{
		"name" : "Cloth Boots",
		"icon" : ICON_PATH + "Cloth Boots.png",
		"def" : 5
	},
	{
		"name" : "Iron Boots",
		"icon" : ICON_PATH + "Iron Boots.png",
		"def" : 10
	},
	{
		"name" : "Steel Boots",
		"icon" : ICON_PATH + "Iron Boots.png",
		"def" : 15
	}
]
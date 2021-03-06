extends HBoxContainer

var itemKind = null
var itemId = 0
var inventoryPos = null

onready var backGround = get_node("ItemBackground")

var white = preload("res://Interfacce Utente/Inventario/whiteTexture.tres")
var black = preload("res://Interfacce Utente/Inventario/blackTexture.tres")

func putItem(kind: int, id : int, pos : int):
	#inizializzo objData con i dati dell'oggetto da inserire
	#se kind = 1 cerco fra le armi, se 2 fra le armature
	var objData
	var objId
	if(kind == 1):
		objData = ItemDB.weapons[id]
		objId = pos
	if(kind == 2):
		objData = ItemDB.armors[id]
		objId = pos
	self.get_node("ItemName").text = objData.name
	self.get_node("ItemBackground/ItemButton").texture_normal = load(objData.icon)
	self.itemKind = kind
	self.itemId = id
	self.inventoryPos = pos

func _on_ItemContainer_gui_input(event):
	if(event is InputEventScreenTouch and event.is_pressed()):
		get_parent().selezionaOggetto(self)
		backGround.texture = white

extends Control

@onready var inventory: Inventory = preload("res://inventory/player_inventory.tres")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.update.connect(update_slots)
	Global.coinsChanged.connect(updateCoinsLabel)
	update_slots()
	close()

func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("i"):
		if is_open:
			close()
		else:
			open()

func close():
	visible = false
	is_open = false
	
func open():
	visible = true
	is_open = true
	
func updateCoinsLabel():
	$Coins_Label.text = str(Global.coins)
	

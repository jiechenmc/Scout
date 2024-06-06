extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var item_count_label: Label = $CenterContainer/Panel/Label

var curr_slot = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update(slot: InventorySlot):
	if !slot.item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		item_count_label.text = str(slot.amount)
	
	curr_slot = slot
		

func _on_panel_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				print("LEFT CLICKED")
			MOUSE_BUTTON_RIGHT:
				if curr_slot.item != null:
					Global.coins += curr_slot.amount
				Global.coinsChanged.emit()
				curr_slot.item = null
				item_visual.visible = false
				item_count_label.visible = false

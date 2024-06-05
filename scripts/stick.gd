extends StaticBody2D


@export var item: InventoryItem
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		player = body
		player_collect()
		
		await get_tree().create_timer(.1).timeout
		
		queue_free()

func player_collect():
	player.collect(item)

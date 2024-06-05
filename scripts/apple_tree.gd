extends Node2D


var state = Global.TREE_STATE.NONE
var player_in_area = false

var apple = preload("res://scenes/apple.tscn")

@export var item: InventoryItem
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if state == Global.TREE_STATE.NONE:
		$growth_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == Global.TREE_STATE.NONE:
		$AnimatedSprite2D.play("default")
	elif state == Global.TREE_STATE.HARVESTABLE:
		$AnimatedSprite2D.play("harvestable")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = Global.TREE_STATE.NONE
				drop_apple()


func _on_growth_timer_timeout():
	if state == Global.TREE_STATE.NONE:
		state = Global.TREE_STATE.HARVESTABLE

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body

func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
		
func drop_apple():
	var apple_instance = apple.instantiate()
	apple_instance.global_position = $Marker2D.global_position
	get_parent().add_child(apple_instance)
	player.collect(item)
	await get_tree().create_timer(3).timeout
	$growth_timer.start()
	

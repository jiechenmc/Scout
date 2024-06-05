extends Node2D

@onready var slime = preload("res://scenes/slime.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_slime_timer_timeout():
	var slime_instance = slime.instantiate()
	slime_instance.position = $player.position
	add_child(slime_instance)
	print("Spawning Slime")

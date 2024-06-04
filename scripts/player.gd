extends CharacterBody2D

var SPEED = 50
func _ready():
	$AnimatedSprite2D.play("idle")
func _physics_process(delta):
	
		
	move_and_slide()

func player_sell_method():
	pass

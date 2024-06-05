extends CharacterBody2D

var SPEED = 100


var state = Global.PLAYER_STATE.IDLE

func _ready():
	pass
	
func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		state = Global.PLAYER_STATE.IDLE
	elif direction.x != 0 or direction.y != 0:
		state = Global.PLAYER_STATE.WALKING
	
	velocity = direction * SPEED
	move_and_slide()
	play_animation(direction)
	

func play_animation(direction):
	if state == Global.PLAYER_STATE.IDLE:
		$AnimatedSprite2D.play("idle")
	elif state == Global.PLAYER_STATE.WALKING:
		if direction.y == -1:
			$AnimatedSprite2D.play("n-walk")
		elif direction.y == 1:
			$AnimatedSprite2D.play("s-walk")		
		elif direction.x == -1:
			$AnimatedSprite2D.play("w-walk")
		elif direction.x == 1:
			$AnimatedSprite2D.play("e-walk")
		elif direction.x > 0.5 and direction.y < -0.5:
			$AnimatedSprite2D.play("ne-walk")
		elif direction.x > 0.5 and direction.y > 0.5:
			$AnimatedSprite2D.play("nw-walk")
		elif direction.x > 0.5 and direction.y > 0.5:
			$AnimatedSprite2D.play("se-walk")
		elif direction.x < -0.5 and direction.y > 0.5:
			$AnimatedSprite2D.play("sw-walk")

func player():
	pass

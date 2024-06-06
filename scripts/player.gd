extends CharacterBody2D

var SPEED = 100


var state = Global.PLAYER_STATE.IDLE
var equip = Global.EQUIP_STATE.NONE
var isWeaponOnCD = false
var mouse_location_from_player = null
var health

var arrow = preload("res://scenes/arrow.tscn")

@export var Inventory:Inventory

func _ready():
	pass
	
func _physics_process(delta):
	
	if health == 0:
		$AnimatedSprite2D.play("death")
		await get_tree().create_timer(1).timeout
		$AnimatedSprite2D.set_frame_and_progress(6, 0)
		return
	
	
	var direction = Input.get_vector("left", "right", "up", "down")
	mouse_location_from_player = get_global_mouse_position() - position
	if direction.x == 0 and direction.y == 0:
		state = Global.PLAYER_STATE.IDLE
	elif direction.x != 0 or direction.y != 0:
		state = Global.PLAYER_STATE.WALKING
	
	velocity = direction * SPEED
	
	
	move_and_slide()
	
	
	if Input.is_action_just_pressed("e"):
		if equip == Global.EQUIP_STATE.NONE:
			equip = Global.EQUIP_STATE.BOW
		else:
			equip = Global.EQUIP_STATE.NONE 
	
	
	var mouse_position = get_global_mouse_position()
	$Marker2D.look_at(mouse_position)
	
	# Input.is_action_just_pressed("click") and 
	if not isWeaponOnCD and equip != Global.EQUIP_STATE.NONE:
		isWeaponOnCD = true
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.position = $Marker2D.global_position
		add_child(arrow_instance)
		
		await get_tree().create_timer(.5).timeout
		
		isWeaponOnCD = false
	
	play_animation(direction)
	

func play_animation(direction):
	if equip == Global.EQUIP_STATE.NONE:
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
	elif equip == Global.EQUIP_STATE.BOW:
		if mouse_location_from_player.x >= -25 and mouse_location_from_player.x <= 25 and mouse_location_from_player.y < 0:
			$AnimatedSprite2D.play("n-attack")
		if mouse_location_from_player.y >= -25 and mouse_location_from_player.y <= 25 and mouse_location_from_player.x > 0:
			$AnimatedSprite2D.play("e-attack")
		if mouse_location_from_player.x >= -25 and mouse_location_from_player.x <= 25 and mouse_location_from_player.y > 0:
			$AnimatedSprite2D.play("s-attack")
		if mouse_location_from_player.y >= -25 and mouse_location_from_player.y <= 25 and mouse_location_from_player.x < 0:
			$AnimatedSprite2D.play("w-attack")
			
		if mouse_location_from_player.x >= 25 and mouse_location_from_player.y <= -25:
			$AnimatedSprite2D.play("ne-attack")	
		if mouse_location_from_player.x >= .5 and mouse_location_from_player.y >= 25:
			$AnimatedSprite2D.play("se-attack")				
		if mouse_location_from_player.x <= -.5 and mouse_location_from_player.y >= 25:
			$AnimatedSprite2D.play("sw-attack")				
		if mouse_location_from_player.x <= -25 and mouse_location_from_player.y <= -25:
			$AnimatedSprite2D.play("nw-attack")				
			
func player():
	pass
	
func collect(item):
	Inventory.insert(item)

func take_damage(damage):
	print("TAKING DAMAGE")
	self.health = 0

extends CharacterBody2D

var speed = 50
var health = 100



var dead = false
var player_in_area = false
var player

@export var item: InventoryItem
@onready var slime = $slime_collectible

func _ready():
	dead = false
	
func _physics_process(delta):
	if not dead:
		$Detection_Zone/CollisionShape2D.disabled = false
		if player_in_area:
			position += (player.position - position) / speed
			$AnimatedSprite2D.play("walk")
		else:
			$AnimatedSprite2D.play("idle")
	else:
		$Detection_Zone/CollisionShape2D.disabled = true
		
	move_and_slide()


func _on_detection_zone_body_entered(body):
	if body.has_method("player"):
		player = body
		player_in_area = true


func _on_detection_zone_body_exited(body):
	if body.has_method("player"):
		player = null
		player_in_area = false


func _on_hitbox_area_entered(area):
	if area.has_method("arrow_deal_damage"):
		var damage = 50
		take_damage(damage)

func take_damage(damage):
	health -= damage
	
	if health <= 0 and not dead:
		death()
		
		
func death():
	dead = true
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(1).timeout
	drop_slime()
	$AnimatedSprite2D.visible = false
	$Hitbox/CollisionShape2D.disabled = true
	$Detection_Zone/CollisionShape2D.disabled = true

func drop_slime():
	slime.visible = true
	$Collect_Area/CollisionShape2D.disabled = false
	await get_tree().create_timer(.5).timeout
	

func collect_slime():
	slime.visible = false
	player.collect(item)
	queue_free()

func _on_collect_area_body_entered(body):
	if body.has_method("player"):
		player = body
		collect_slime()


func _on_attack_area_body_entered(body):
	if body.has_method("player"):
		print("PLAYER TAKING DAMAGE")
		player = body
		player.take_damage(0)

extends CharacterBody2D

signal landed

var pickups = 0

@export var walk_speed = 800.0
@export var jump_speed = -900.0

@onready var animatedSprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity:int = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 0
var grounded = false

signal damaged(by)
signal killed()

const HP_MAX = 150.0
var hp = HP_MAX

#Only runs when input happens
func _input(event):
	if Input.is_action_pressed("jump_1") and is_on_floor():
		jump()
	if event.is_action("move_1"):
		move(Input.get_axis("move_left_1", "move_right_1"))
	if event.is_action("attack_1"):
		attack()
	
func attack():
	$Sword/Sprite2D/Area2D/HitBox.disabled = false
	$Sword/Sprite2D/AnimationPlayer.play("hit")
	await get_tree().create_timer(0.7).timeout
	$Sword/Sprite2D/Area2D/HitBox.disabled = true

func jump():
	velocity.y = jump_speed
	animatedSprite.play("jump")


func _physics_process(delta):
	ground_check(delta)
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, walk_speed)
	else:
		velocity.x = direction * walk_speed
		
	if direction>0:
		$Sword/Sprite2D.flip_h = false
		$Sword.scale.x = 1
		#$Sword/Sprite2D.position = Vector2(-47,90)
	else:
		$Sword/Sprite2D.flip_h = true
		$Sword.scale.x = -1
		#$Sword/Sprite2D.position = Vector2(47,90)
	move_and_slide()

func ground_check(delta):
	var was_grounded = grounded
	grounded = is_on_floor()
	if not grounded:
		velocity.y += gravity * delta
	elif not was_grounded:
		landed.emit()

func add_pickup():
	pickups = pickups + 1

func move(dir):
	direction = dir
	if dir == 0:
		animatedSprite.play("idle")
	else:
		animatedSprite.play("walk")
	animatedSprite.flip_h = dir < 0


func _on_landed():
	if direction == 0:
		animatedSprite.play("idle")
	else:
		animatedSprite.play("walk")


func jump_finished():
	if grounded:
		animatedSprite.play("idle")
	else:
		animatedSprite.play("Fall")


func take_damage(amount):
	hp-=amount
	if hp<0:
		print("dead")


func _on_area_2d_body_entered(body):
	if body.is_in_group("mobs"):
		body.take_damage(30)
		print("attack_sword")


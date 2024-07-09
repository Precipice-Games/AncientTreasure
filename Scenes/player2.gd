extends CharacterBody2D

signal landed

var pickups = 0

@export var walk_speed = 300.0
@export var jump_speed = -500.0

@onready var animatedSprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity:int = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 0
var grounded = false


#Only runs when input happens
func _input(event):
	if Input.is_action_pressed("jump_2") and is_on_floor():
		jump()
	if event.is_action("move_2"):
		move(Input.get_axis("move_left_2", "move_right_2"))

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
		$Gun/Sprite2D.flip_h = false
		$Gun/Sprite2D.position = Vector2(88,80)
	else:
		$Gun/Sprite2D.flip_h = true
		$Gun/Sprite2D.position = Vector2(-88,80)
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

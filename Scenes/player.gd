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
	if Input.is_action_pressed("Jump") and is_on_floor():
		jump()
	if event.is_action("Move"):
		move(Input.get_axis("Left", "Right"))

func jump():
	velocity.y = jump_speed
	animatedSprite.play("Jump")


func _physics_process(delta):
	ground_check(delta)
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, walk_speed)
	else:
		velocity.x = direction * walk_speed
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
		animatedSprite.play("Idle")
	else:
		animatedSprite.play("Walking")
	animatedSprite.flip_h = dir < 0


func _on_landed():
	if direction == 0:
		animatedSprite.play("Idle")
	else:
		animatedSprite.play("Walking")


func jump_finished():
	if grounded:
		animatedSprite.play("Idle")
	else:
		animatedSprite.play("Fall")

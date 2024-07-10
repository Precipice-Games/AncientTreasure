extends CharacterBody2D

@export var speed:int = 0
var direction = 1

var player_detected:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player_detected:
		jump():
		velocity.y = jump_speed
		animatedSprite.play("attack")
	else:
		velocity.x = direction * speed
	move_and_slide()

func check_floor():
	if not $FloorCheck.is_colliding():
		direction = direction * -1

func _on_player_detection_area_entered(area):
	player_detected = true

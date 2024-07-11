extends CharacterBody2D

@export var speed:int = 0
var direction = 1
@export var jump_speed = -600
@export var gravity:int = ProjectSettings.get_setting("physics/2d/default_gravity")

var player_detected:bool = false
var can_jump:bool = true
var can_attack:bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
		check_player()
	else:
		can_jump=true
		check_floor()
	
	if player_detected and can_jump:
		velocity.y = jump_speed
		$AnimatedSprite2D.play("attack")
		can_jump=false
	else:
		velocity.x = direction * speed
	
	move_and_slide()

func check_floor():
	if not $FloorCheck.is_colliding():
		$FloorCheck.position.x *= -1
		direction = direction * -1
		$AnimatedSprite2D.play("walk")

func check_player():
	if $FloorCheck.is_colliding():
		var collider = $FloorCheck.get_collider()
		if collider.is_in_group("players") and can_attack:
			print("attack")
			collider.take_damage(25)
			$AttackTimer.start()
			can_attack=false
		else:
			print("not ready")


func _on_player_detection_body_entered(body):
	player_detected = true

func _on_player_detection_body_exited(body):
	player_detected = false


func _on_attack_timer_timeout():
	can_attack=true

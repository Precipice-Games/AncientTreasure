extends Area2D

@export var speed = 500
var velocity = Vector2(1, 0)

func _physics_process(delta): ##TODO move in direction
	position += velocity * delta
	
#func _ready():
#	velocity = velocity * speed

func initialize(player_direction):
	var direction
	if player_direction == 1:
		direction = 1
	else:
		direction = -1
	
	velocity = velocity * direction * speed


func _on_body_entered(body):
	if body.is_in_group("mobs"):
		body.take_damage(30)
		print("attack_gun")

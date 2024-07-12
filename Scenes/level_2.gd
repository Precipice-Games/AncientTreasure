extends Node2D

@export var lever1Pulled:bool = false

@export var button1:bool = false
@export var button2:bool = false

func game_over():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_lava_body_entered(body):
	if body.is_in_group("players"):
		print("dies but not")
		#body.die()
		game_over()



func _on_lever_1_body_entered(body):
	$Lever1/Lever1.play("LeverTurnOn")
	if lever1Pulled == false:
		create_tween().tween_property($Lava4, "global_position", $Lava4.global_position + Vector2(980, -1450), 1)
		lever1Pulled = true
	else:
		lever1Pulled = true

	

func _on_button_1_body_entered(body):
	button1 = true
	$MovingPlat/Button1/Button1.play("ButtonOn")
	movePlat()


func _on_button_2_body_entered(body):
	button2 = true
	$MovingPlat/Button2/Button2.play("ButtonOn")
	movePlat()

func movePlat():
	if button1 and button2:
		create_tween().tween_property($MovingPlat, "global_position", Vector2(5, 712), 1)

func _on_button_1_body_exited(body):
	button1 = false
	$MovingPlat/Button1/Button1.play("ButtonOff")
	create_tween().tween_property($MovingPlat, "global_position", Vector2(2600, 60), 1)


func _on_button_2_body_exited(body):
	button2 = false
	$MovingPlat/Button2/Button2.play("ButtonOff")
	create_tween().tween_property($MovingPlat, "global_position", Vector2(2600, 60), 1)



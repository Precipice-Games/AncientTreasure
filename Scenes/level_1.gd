extends Node2D

var currency = 0
@export var lever1Pulled:bool = false
@export var lever2Pulled:bool = false

@export var button1on:bool = false
@export var button2on:bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	#$Coin1/Coin1Spr.play("SpinningCoin")
	#$Coin2/Coin2Spr.play("SpinningCoin")
	#$Coin3/Coin3Spr.play("SpinningCoin")
	#$Coin4/Coin4Spr.play("SpinningCoin")
	#$Coin5/Coin5Spr.play("SpinningCoin")
	#$Coin6/Coin6Spr.play("SpinningCoin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over():
	currency = 0

func _on_lever_1_area_entered(area):
	if lever1Pulled == true:
		$Lever1/Lever1.play("LeverTurnOff")
		lever1Pulled = false
	else:
		$Lever1/Lever1.play("LeverTurnOn")
	#set the bool
	#layer1 check
		lever1Pulled = true
	layer1()


func _on_lever_2_area_entered(area):
	if lever2Pulled == true:
		$Lever2/Lever2.play("LeverTurnOff")
		lever2Pulled = false
	else:
		$Lever2/Lever2.play("LeverTurnOn")
		lever2Pulled = true
	layer1()

func layer1():
	if lever1Pulled and lever2Pulled:
		var tween = create_tween()
		tween.tween_property($Layer1, "global_position", $Layer1.global_position + Vector2(0, 1000), 2)
		
		


func _on_button_1_body_entered(body):
	$Button1/Button1.play("ButtonOn")
	button1on = true
	create_tween().tween_property($Layer3, "global_position", $Layer3End.global_position, 1)


func _on_button_2_body_entered(body):
	$Button2/Button2.play("ButtonOn")
	button2on = true
	create_tween().tween_property($Layer2, "global_position", $Layer2End.global_position, 1)
	


func _on_button_1_body_exited(body):
	$Button1/Button1.play("ButtonOff")
	button1on = false
	create_tween().tween_property($Layer3, "global_position", $Layer3Start.global_position, 1)


func _on_button_2_body_exited(body):
	$Button2/Button2.play("ButtonOff")
	button2on = false
	create_tween().tween_property($Layer2, "position", $Layer2Start.position, 1)




func _on_lava_body_entered(body):
	game_over()

extends Node2D



var currency = 0
@export var lever1Pulled:bool = false
@export var lever2Pulled:bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over():
	currency = 0

func _on_lever_1_area_entered(area):
	$Lever1/Lever1.play("LeverTurnOn")
	#set the bool
	#layer1 check
	lever1Pulled = true
	layer1()


func _on_lever_2_area_entered(area):
	$Lever2.play("LeverTurnOn")
	lever2Pulled = true
	layer1()

func layer1():
	if lever1Pulled and lever2Pulled:
		$MoveLayer1.y.coordinate += 15
		



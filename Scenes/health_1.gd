extends Control

func _on_player_1_damaged(amount):
	$Health.value-= amount

func _on_player_collect(amount):
	$Coins.text = str(amount)
	

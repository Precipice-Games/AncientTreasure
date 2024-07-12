extends Control

func _on_player_1_damaged(amount):
	$Health.value-= amount

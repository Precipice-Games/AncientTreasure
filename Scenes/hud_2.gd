extends Control

func _on_player_2_damaged(amount):
	$HealthBar.value-= amount
	

extends Control

func _on_player_2_damaged(amount):
	$HealthBar.value-= amount
	
func _on_player_collect(amount):
	$Coins.text = str(amount)

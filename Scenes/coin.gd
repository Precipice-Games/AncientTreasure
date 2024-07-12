extends Area2D

func _on_body_entered(body):
	if body.name == "Player1":
		body.collect_coin()
	elif body.name=="Player2":
		body.collect_coin()
	queue_free()

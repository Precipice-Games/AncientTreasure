extends Area2D

var count = 0

func _on_body_entered(body):
	body.queue_free()
	count += 1
	if count == 2:
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/level_2.tscn")

extends CanvasLayer

@export_file var level1_scene



func _on_press_here_pressed():
	get_tree().change_scene_to_file(level1_scene)
	$GameOver.play()

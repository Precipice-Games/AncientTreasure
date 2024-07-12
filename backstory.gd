extends CanvasLayer

@export_file var start_menu


func _on_back_button_pressed():
	get_tree().change_scene_to_file(start_menu)

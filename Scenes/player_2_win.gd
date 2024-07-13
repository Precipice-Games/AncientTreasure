extends CanvasLayer

@export_file var start_menu
@export_file var level1_scene

func _on_restart_pressed():
	get_tree().change_scene_to_file(level1_scene)



func _on_main_menu_pressed():
	get_tree().change_scene_to_file(start_menu)

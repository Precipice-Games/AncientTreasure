extends CanvasLayer

@export_file var level1_scene
@export_file var credits_scene
@export_file var backstory_scene


func _ready():
	$Music.play()

func _on_start_button_pressed():
	get_tree().change_scene_to_file(level1_scene)


func _on_credits_button_pressed():
	get_tree().change_scene_to_file(credits_scene)



func _on_story_button_pressed():
	get_tree().change_scene_to_file(backstory_scene)

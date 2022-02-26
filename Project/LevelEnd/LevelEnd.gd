extends Control

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			sceneManager.load_level_select_scene()

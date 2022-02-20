extends Control

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			sceneManager.quit_game()

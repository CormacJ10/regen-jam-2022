extends Node
class_name SceneManager

func load_level_scene():
	get_tree().change_scene("res://Level/Level.tscn")

func load_main_menu_scene():
	get_tree().change_scene("res://MainMenu/MainMenu.tscn")

func load_level_select_scene():
	get_tree().change_scene("res://LevelSelect/LevelSelect.tscn")

func load_level_end_scene():
	get_tree().change_scene("res://LevelEnd/LevelEnd.tscn")

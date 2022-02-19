extends Node2D
class_name Level

export(int) var time_limit = 4;
export(int) var action_limit = 2;

export(float) var soil_quality = 0;
export(float) var air_quality = 0;
export(float) var water_quality = 0;

export(float) var soil_quality_target = 0;
export(float) var air_quality_target = 0;
export(float) var water_quality_target = 0;

signal end_turn;
signal take_action;

signal action_changed(new_value)
signal turn_changed(new_value)
signal air_quality_changed(new_value)
signal water_quality_changed(new_value)
signal soil_quality_changed(new_value)

#Enum for whether or not the player has selected a building
enum State{
	DESELECTED,
	SELECTED
}

onready var grid: Grid = $Grid
onready var gui: LevelGUI = $CanvasLayer/LevelGUI

var selected_tile: TileData
var current_state = State.DESELECTED
var current_turn: int = 1
var current_action: int = 1
var tiles: Array = []

func _ready():
	load_tiles()
	play_turn()

func load_tiles():
	var dir: Directory = Directory.new()
	if dir.open("res://Tiles/") == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		while (file_name != ""):
			if !dir.current_is_dir():
				tiles.push_back(load("res://Tiles/%s"%file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	gui.set_tiles(tiles)

func play_turn():
	print("Turn: %d"%current_turn)
	current_action = 1;
	yield(self, "end_turn")
	advance_turn();

func advance_turn():
	current_turn+=1;
	if current_turn > time_limit:
		end_level()
	else:
		grid.advance_turn()
		emit_signal("turn_changed", current_turn)
		play_turn()

func end_level():
	#TODO: Send level results to next scene
	sceneManager.load_level_end_scene()

func on_tile_clicked(x_index, y_index):
	match current_state:
		State.DESELECTED:
			pass
		State.SELECTED:
			grid.set_tile(x_index, y_index, selected_tile)
			emit_signal("take_action")

func on_take_action():
	print("Action: %d"%current_action);
	current_action += 1;
	if current_action > action_limit:
		emit_signal("end_turn")
	else:
		emit_signal("action_changed", current_action)

func on_tile_hovered(x_index, y_index):
	match current_state:
		State.DESELECTED:
			grid.highlight_tile(x_index, y_index)
		State.SELECTED:
			grid.indicate_tile(x_index, y_index, selected_tile)


func on_LevelGUI_tile_clicked(tile):
	selected_tile = tile
	current_state = State.SELECTED;


func on_Grid_change_air_quality(delta):
	air_quality += delta
	emit_signal("air_quality_changed", air_quality)

func on_Grid_change_soil_quality(delta):
	soil_quality += delta
	emit_signal("soil_quality_changed", soil_quality)

func on_Grid_change_water_quality(delta):
	water_quality += delta
	emit_signal("water_quality_changed", water_quality)

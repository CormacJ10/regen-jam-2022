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

onready var grid: Grid = $Grid;

var current_turn: int = 1;
var current_action: int = 1;
#TODO: Implement buildings
var selected_building;

func _ready():
	play_turn();

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
		emit_signal("turn_changed", current_turn)
		play_turn()

func end_level():
	#TODO: Calculate score and change scene
	print("Level over")

func on_tile_clicked(x_index, y_index):
	print("(%d,%d)"%[x_index,y_index])
	#TODO: Handle click
	emit_signal("take_action")

func on_take_action():
	print("Action: %d"%current_action);
	current_action += 1;
	if current_action > action_limit:
		emit_signal("end_turn")
	else:
		emit_signal("action_changed", current_action)

func on_tile_hovered(x_index, y_index):
	#TODO: Handle when the player has selected a building
	#TODO: Display some info about the tile
	grid.highlight_tile(x_index, y_index)


func on_LevelGUI_tile_clicked(tile):
	pass # Replace with function body.

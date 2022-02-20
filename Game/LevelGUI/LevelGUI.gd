extends Control
class_name LevelGUI

signal tile_clicked(tile)

onready var turn_label: Label = $TurnLabel
onready var action_indicator: Panel = $DaylightIndicator
onready var health_bars: HealthBarsObject = $HealthBarsObject
onready var tiles_container: GridContainer = $Tiles

var tiles: Array = []
var tile_buttons: Array = []

var current_turn: int = 1
var current_action: int = 1
var current_air_quality: float = 0
var current_water_quality: float = 0
var current_soil_quality: float = 0

func _ready():
	update_labels()

func set_tiles(p_tiles: Array):
	for tile in p_tiles:
		add_tile(tile)
		

func add_tile(tile: TileData):
	tiles.push_back(tile);
	var tile_button: Button = Button.new()
	tile_button.text = tile.name
	tile_buttons.push_back(tile_button)
	tiles_container.add_child(tile_button)
	tile_button.connect("pressed", self, "on_tile_clicked", [tile])

func update_labels():
	turn_label.text = "Turn %d of 4"%current_turn
	health_bars.air_bar.value = current_air_quality
	health_bars.water_bar.value = current_water_quality
	health_bars.soil_bar.value = current_soil_quality
	for i in range(action_indicator.get_child_count()):
		if i+1 == current_action:
			action_indicator.get_child(i).visible = true
		else:
			action_indicator.get_child(i).visible = false

func on_tile_clicked(tile: TileData):
	emit_signal("tile_clicked", tile)

func on_turn_changed(new_value: int):
	current_turn = new_value
	current_action = 1
	update_labels()

func on_action_changed(new_value: int):
	current_action = new_value
	update_labels()


func on_air_quality_changed(new_value: float):
	current_air_quality = new_value
	update_labels()


func on_soil_quality_changed(new_value: float):
	current_soil_quality = new_value
	update_labels()


func on_water_quality_changed(new_value: float):
	current_water_quality = new_value
	update_labels()

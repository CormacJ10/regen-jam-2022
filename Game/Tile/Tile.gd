extends Area2D
class_name Tile

signal clicked(x_index, y_index)
signal hovered(x_index, y_index)
signal change_air_quality(delta)
signal change_water_quality(delta)
signal change_soil_quality(delta)

export(Resource) var default_tile;

onready var sprite: Sprite = $Sprite
onready var indicator: Sprite = $Indicator
onready var data: TileData = default_tile setget set_data

var x_index: int
var y_index: int
var life_time: int

func _ready():
	update_data();

func set_data(new_data: TileData):
	data = new_data
	update_data()

func update_data():
	life_time = data.life_time
	sprite.texture = data.sprite
	
func advance_turn():
	if life_time > 0:
		life_time -= 1;
		if life_time > 0:
			ongoing()
		else:
			if data.next != null:
				set_data(data.next)
				entered()
			else:
				exited()
				data = default_tile
	else:
		print("Ongoing")
		ongoing()
	
func ongoing():
	emit_signal("change_air_quality", data.ongoing_air_quality_delta)
	emit_signal("change_water_quality", data.ongoing_water_quality_delta)
	emit_signal("change_soil_quality", data.ongoing_soil_quality_delta)
	
func entered():
	emit_signal("change_air_quality", data.entry_air_quality_delta)
	emit_signal("change_water_quality", data.entry_water_quality_delta)
	emit_signal("change_soil_quality", data.entry_soil_quality_delta)
	
func exited():
	emit_signal("change_air_quality", data.exit_air_quality_delta)
	emit_signal("change_water_quality", data.exit_water_quality_delta)
	emit_signal("change_soil_quality", data.exit_soil_quality_delta)
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", x_index, y_index)

func highlight():
	pass
	#position.y -= 10;

func indicate(tile: TileData):
	indicator.texture = tile.sprite
	indicator.visible = true
	#position.y -= 10;

func on_mouse_entered():
	emit_signal("hovered", x_index, y_index)

func on_mouse_exited():
	#position.y += 10;
	indicator.visible = false;

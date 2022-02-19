extends Area2D
class_name Tile

export(Resource) var data

signal clicked(x_index, y_index)
signal hovered(x_index, y_index)

onready var indicator: Sprite = $Indicator

var x_index: int;
var y_index: int;

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", x_index, y_index)

func highlight():
	position.y -= 10;

func on_mouse_entered():
	emit_signal("hovered", x_index, y_index)

func on_mouse_exited():
	position.y += 10;
	indicator.visible = false;

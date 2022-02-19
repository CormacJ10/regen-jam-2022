extends Node2D
class_name Grid

export(int) var width = 10;
export(int) var height = 10;
export(float) var tile_size = 64;

signal tile_clicked(x_index, y_index)
signal tile_hovered(x_index, y_index)

const tile_scene: PackedScene = preload("res://Tile/Tile.tscn");

var tiles: Array = [];

func _ready():
	for x in range(width):
		tiles.push_back([])
		for y in range(height):
			tiles[x].push_back(initialise_tile(x, y))

func initialise_tile(x: int, y: int) -> Tile:
	var tile: Tile = tile_scene.instance()
	tile.x_index = x
	tile.y_index = y
	tile.position.x = (x + 0.5) * tile_size
	tile.position.y = (y + 0.5) * tile_size
	tile.connect("clicked", self, "on_tile_clicked")
	tile.connect("hovered", self, "on_tile_hovered")
	add_child(tile)
	return tile

func highlight_tile(x_index: int, y_index: int):
	tiles[x_index][y_index].highlight()

func on_tile_clicked(x_index: int, y_index: int):
	emit_signal("tile_clicked", x_index, y_index)

func on_tile_hovered(x_index: int, y_index: int):
	emit_signal("tile_hovered", x_index, y_index)

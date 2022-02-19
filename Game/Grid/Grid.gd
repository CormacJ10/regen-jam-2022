extends Node2D
class_name Grid

export(int) var width = 10;
export(int) var height = 10;
export(float) var tile_size = 64;
export(Resource) var default_tile;

signal tile_clicked(x_index, y_index)
signal tile_hovered(x_index, y_index)
signal change_air_quality(delta)
signal change_water_quality(delta)
signal change_soil_quality(delta)

const tile_scene: PackedScene = preload("res://Tile/Tile.tscn");

var tiles: Array = [];

func _ready():
	for x in range(width):
		tiles.push_back([])
		for y in range(height):
			tiles[x].push_back(initialise_tile(x, y))

func initialise_tile(x: int, y: int) -> Tile:
	var tile: Tile = tile_scene.instance()
	tile.default_tile = default_tile
	tile.x_index = x
	tile.y_index = y
	tile.position.x = (x + 0.5) * tile_size
	tile.position.y = (y + 0.5) * tile_size
	tile.connect("clicked", self, "on_tile_clicked")
	tile.connect("hovered", self, "on_tile_hovered")
	tile.connect("change_air_quality", self, "on_air_quality_changed")
	tile.connect("change_water_quality", self, "on_water_quality_changed")
	tile.connect("change_soil_quality", self, "on_soil_quality_changed")
	add_child(tile)
	return tile

func highlight_tile(x_index: int, y_index: int):
	tiles[x_index][y_index].highlight()
	
func indicate_tile(x_index: int, y_index: int, tile: TileData):
	tiles[x_index][y_index].indicate(tile)

func set_tile(x_index: int, y_index: int, tile: TileData):
	tiles[x_index][y_index].data = tile
	tiles[x_index][y_index].entered()

func advance_turn():
	for x in range(len(tiles)):
		for y in range(len(tiles[x])):
			tiles[x][y].advance_turn();

func on_tile_clicked(x_index: int, y_index: int):
	emit_signal("tile_clicked", x_index, y_index)

func on_tile_hovered(x_index: int, y_index: int):
	emit_signal("tile_hovered", x_index, y_index)

func on_air_quality_changed(delta):
	emit_signal("change_air_quality", delta)

func on_water_quality_changed(delta):
	emit_signal("change_water_quality", delta)
	
func on_soil_quality_changed(delta):
	emit_signal("change_soil_quality", delta)

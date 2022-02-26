extends Resource
class_name TileData

export(String) var name #i.e Covercrop
export(String) var description #i.e Used to maintain soil quality after you've harvested your main crop

export(float) var entry_soil_quality_delta
#TODO: Decide if we're rolling with these
export(float) var entry_air_quality_delta
export(float) var entry_water_quality_delta

export(float) var ongoing_soil_quality_delta
#TODO: Decide if we're rolling with these
export(float) var ongoing_air_quality_delta
export(float) var ongoing_water_quality_delta

export(float) var exit_soil_quality_delta
#TODO: Decide if we're rolling with these
export(float) var exit_air_quality_delta
export(float) var exit_water_quality_delta

export(int) var score_delta #How many bonus points this tile gives you
export(int) var life_time #How many turns this tile lasts

export(Texture) var sprite # The sprite for this tile
export(Resource) var next #What tile this tile turns into when it dies

func _init(
	p_name = "",
	p_description = "",
	p_entry_soil_quality_delta = 0,
	p_entry_air_quality_delta = 0,
	p_entry_water_quality_delta = 0,
	p_ongoing_soil_quality_delta = 0,
	p_ongoing_air_quality_delta = 0,
	p_ongoing_water_quality_delta = 0,
	p_exit_soil_quality_delta = 0,
	p_exit_air_quality_delta = 0,
	p_exit_water_quality_delta = 0,
	p_score_delta = 0,
	p_life_time = 0,
	p_sprite = null,
	p_next = null
):
	name = p_name
	description = p_description
	entry_soil_quality_delta = p_entry_soil_quality_delta
	entry_air_quality_delta = p_entry_air_quality_delta
	entry_water_quality_delta = p_entry_water_quality_delta
	ongoing_soil_quality_delta = p_ongoing_soil_quality_delta
	ongoing_air_quality_delta = p_ongoing_air_quality_delta
	ongoing_water_quality_delta = p_ongoing_water_quality_delta
	exit_soil_quality_delta = p_exit_soil_quality_delta
	exit_air_quality_delta = p_exit_air_quality_delta
	exit_water_quality_delta = p_exit_water_quality_delta
	score_delta = p_score_delta
	life_time = p_life_time
	sprite = p_sprite
	next = p_next

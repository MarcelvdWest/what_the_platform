extends TileMapLayer

@export var StaticPlatform = preload("res://static_platform.tscn")
@export var MovingPlatform = preload("res://moving_platform.tscn")
#@export var platform_tile_ids: Array[int] = [1] # tile IDs that should act as platforms
@export var tile_width: int = 16

func _ready():
	generate_platforms()

func generate_platforms():
	var used_cells = get_used_cells()
	var checked: Dictionary = {}

	for cell in used_cells:
		if cell in checked:
			continue
			
		var tile_data = get_cell_tile_data(cell)
		if not tile_data:
			continue # skip tiles without custom data

		# Get the custom "type" property
		var platform_type = tile_data.get_custom_data("type")
		if not platform_type:
			continue
			
		# Find contiguous row of tiles with the same type	
		var row: Array = []
		var x = cell.x
		while Vector2i(x, cell.y) in used_cells:
			var t_data = get_cell_tile_data(Vector2i(x, cell.y))
			if not t_data or t_data.get_custom_data("type") != tile_data.get_custom_data("type"):
				break
			row.append(Vector2i(x, cell.y))
			checked[Vector2i(x, cell.y)] = true
			x += 1
				
		# Spawn one platform for the row
		spawn_platform(row, tile_data)
			
func spawn_platform(row: Array, tile_data: Object):
	var platform
	#print(tile_data.get_custom_data("type"))
	match tile_data.get_custom_data("type"):
		"static":
			platform = StaticPlatform.instantiate()
		"moving":
			platform = MovingPlatform.instantiate()
		_:
			print("not a valid type")
			return
			
	#get_parent().add_child(platform)
	add_child(platform)
	
	#print("added child:", platform.get_parent())

		
	#print(platform)
 	#Calculate world position of the row center
	print(row[0])
	var start_pos = map_to_local(row[0])
	var end_pos   = map_to_local(row[-1])
	var center    = (start_pos + end_pos) / 2
	platform.position = start_pos

	#await platform.get_tree().process_frame
	#print(platform.col_shape)
	#platform.setup_from_tile_data(tile_data, tile_width, row.size())
	print("TEST")
	platform.call_deferred("setup_from_tile_data", tile_data, tile_width, row.size())

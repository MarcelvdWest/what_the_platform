extends TileMapLayer


@export var platform_scene: PackedScene
@export var platform_tile_ids: Array[int] = [1] # tile IDs that should act as platforms
@export var tile_width: int = 16

func _ready():
	generate_platforms()
	
func generate_platforms():
	var used_cells = get_used_cells()
	var checked: Dictionary = {}
	
	print(user_cells)
	for cell in used_cells:
		if cell in checked:
			continue
		
		var tile_id = get_cell_source_id(cell)
		if tile_id in platform_tile_ids:
			#Collect a contiguous(sharing a common border) row
			var row: Array = []
			var x = cell.x
			while Vector2i(x, cell.y) in used_cells and get_cell_source_id(Vector2i(x, cell.y)) in platform_tile_ids:
				row.append(Vector2i(x, cell.y))
				checked[Vectoe2i(x, cell.y)] = true
				x += 1

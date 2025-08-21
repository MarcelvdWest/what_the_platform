extends StaticBody2D

#@export var default_type: String = "static"

@onready var col_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	print("READY called: col_shape =", col_shape)

# Initialize platform from metadata
func setup_from_tile_data(tile_data: Object, tile_width: int, tile_count: int):
	# Set collision shape based on tile count
	set_size(tile_width, tile_count)

func set_size(tile_width: int, tile_count: int):
	var rect = RectangleShape2D.new()
	rect.extents = Vector2((tile_width * tile_count) / 2, 8)
	col_shape.shape = rect
	col_shape.position = Vector2((tile_width * tile_count) / 2, 8)

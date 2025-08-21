extends StaticBody2D


#@export var default_type: String = "static"
#@export var default_speed: float = 50.0
#@export var default_direction: Vector2 = Vector2(1, 0)

@onready var col_shape: CollisionShape2D = $StaticBody2D/CollisionShape2D

func _ready() -> void:
	print("READY called: col_shape =", col_shape)


# Initialize platform from metadata
func setup_from_tile_data(tile_data: Object, tile_width: int, tile_count: int):
	
	#var speed = default_speed
	#var direction = default_direction

	# Set collision shape based on tile count
	set_size(tile_width, tile_count)

	# If this is a moving platform, start motion
	#start_moving(speed, direction)

func set_size(tile_width: int, tile_count: int):
	var rect = RectangleShape2D.new()
	rect.extents = Vector2((tile_width * tile_count) / 2, 8)
	col_shape.shape = rect
	col_shape.position = Vector2((tile_width * tile_count) / 2, 8)
	
#func start_moving(speed: float, direction: Vector2):
	## Use a Tween for simple back-and-forth motion
	#var tween = create_tween().set_loops()
	#var start_pos = position
	#var end_pos = position + direction * 64  # Move 64 pixels
	#tween.tween_property(self, "position", end_pos, 2.0).as_relative()
	#tween.tween_property(self, "position", start_pos, 2.0).as_relative()

extends TileMap
class_name Map

var crates : Dictionary
@onready var walls = $Walls
@onready var checkpoints = $Checkpoints
@onready var cratePositions = $Crates
@onready var playerPosition = $Player

func _ready():
	cratePositions.visible = false
	playerPosition.visible = false

func isEmpty(tilePosition : Vector2i):
	return !crates.has(tilePosition) and walls.get_cell_source_id(0, tilePosition) == -1

func hasCrate(tilePosition : Vector2i):
	return crates.has(tilePosition)

func isCheckpoint(tilePosition : Vector2i):
	return checkpoints.get_cell_source_id(0, tilePosition) == 0

extends Node

@export var playerScene: PackedScene
@export var crateScene: PackedScene

@onready var map : Map = $Level2
@onready var playerController = $PlayerController

var player : Player

func _ready():
	SetupPlayer()
	SetupPlayerController()
	SetupCrates()

func SetupPlayer():
	player = playerScene.instantiate()
	add_child(player)
	var playerPosition = map.playerPosition.get_used_cells(0)[0]
	player.position = map.map_to_local(playerPosition)
	player.tilePosition = playerPosition

func SetupPlayerController():
	playerController.map = map
	playerController.player = player

func SetupCrates():
	for tilePosition in map.cratePositions.get_used_cells(0):
		var crate = crateScene.instantiate()
		add_child(crate)
		crate.position = map.map_to_local(tilePosition)
		crate.tilePosition = tilePosition
		crate.map = map
		map.crates[tilePosition] = crate

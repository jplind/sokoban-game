extends Node

@export var playerScene: PackedScene
@export var crateScene: PackedScene

@onready var map : Map
@onready var playerController = $PlayerController
@onready var menuScreen = $MenuScreen
@onready var levels = %Levels
@onready var current_level = %CurrentLevel
@onready var scene_transition = %SceneTransition

var player : Player

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		scene_transition.fade_out()
		await scene_transition.animation_finished
		map.hide()
		for child in current_level.get_children():
			child.queue_free()
		menuScreen.show()
		levels.get_children()[0].show()
		scene_transition.fade_in()

func _ready():
	menuScreen.levelSelected.connect(playLevel)

func playLevel(level):
	scene_transition.fade_out()
	await scene_transition.animation_finished
	levels.get_children()[0].hide()
	map = levels.get_child(level)
	map.show()
	SetupPlayer()
	SetupPlayerController()
	SetupCrates()
	menuScreen.hide()
	scene_transition.fade_in()

func SetupPlayer():
	player = playerScene.instantiate()
	current_level.add_child(player)
	var playerPosition = map.playerPosition.get_used_cells(0)[0]
	player.position = map.map_to_local(playerPosition)
	player.tilePosition = playerPosition

func SetupPlayerController():
	playerController.map = map
	playerController.player = player
	playerController.moveHistory.clear()

func SetupCrates():
	map.crates.clear()
	for tilePosition in map.cratePositions.get_used_cells(0):
		var crate = crateScene.instantiate()
		current_level.add_child(crate)
		crate.position = map.map_to_local(tilePosition)
		crate.tilePosition = tilePosition
		crate.map = map
		map.crates[tilePosition] = crate

extends Node

var player : Player
var map : Map
var moveHistory = []

func _process(_delta):
	if player.walking:
		return
	
	if Input.is_action_pressed("undo"):
		undo()
		return
	
	var direction : Vector2i
	
	if Input.is_action_pressed("up"):
		direction = Vector2i.UP
	elif Input.is_action_pressed("down"):
		direction = Vector2i.DOWN
	elif Input.is_action_pressed("left"):
		direction = Vector2i.LEFT
	elif Input.is_action_pressed("right"):
		direction = Vector2i.RIGHT
	else:
		return
	
	var destination = player.tilePosition + direction
	
	if map.hasCrate(destination):
		if map.isEmpty(destination + direction):
			var move = Move.new()
			move.actor = map.crates[destination]
			move.startPosition = destination
			move.endPosition = destination + direction
			moveHistory.append(move)
			map.crates[destination].move(direction)
	
	if map.isEmpty(destination):
		var move = Move.new()
		move.actor = player
		move.startPosition = player.tilePosition
		move.endPosition = destination
		moveHistory.append(move)
		player.move(direction)
	else:
		player.turn(direction)

func undo():
	var move = moveHistory.pop_back()
	
	if move == null:
		return
	
	var direction =  move.startPosition - move.endPosition
	move.actor.backwardMove(direction)
	
	if moveHistory.is_empty():
		return
	
	if moveHistory[-1].actor.is_in_group("crates"):
		move = moveHistory.pop_back()
		direction = move.startPosition - move.endPosition
		move.actor.move(direction)

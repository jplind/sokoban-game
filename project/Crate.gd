extends Node2D

var tilePosition : Vector2i
var map : Map
var isOnCheckpoint : bool = false

@onready var moveTimer = $MoveTimer

func _ready():
	pass

func move(direction : Vector2i):
	var tween = create_tween()
	tween.tween_property(self, "position", self.position + Vector2(direction) * 64, 0.2).set_trans(Tween.TRANS_SINE)
	tween.play()
	tilePosition += direction
	map.crates[tilePosition] = self
	map.crates.erase(tilePosition - direction)
	moveTimer.start()

func _on_move_timer_timeout():
	if map.isCheckpoint(tilePosition):
		isOnCheckpoint = true
		$Sprite2D.frame = 1
		for crate in get_tree().get_nodes_in_group("crates"):
			if !crate.isOnCheckpoint:
				return
		print("win")
	else:
		isOnCheckpoint = false
		$Sprite2D.frame = 0

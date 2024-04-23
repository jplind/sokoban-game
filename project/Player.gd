extends Node2D
class_name Player

var tilePosition : Vector2i
var facing : String = "down"
var walking : bool = false

@onready var sprite = $Sprite2D
@onready var moveTimer = $MoveTimer

func _ready():
	pass

func move(direction : Vector2i):
	match direction:
		Vector2i.UP:
			facing = "up"
			sprite.play("walkingUp")
		Vector2i.DOWN:
			facing = "down"
			sprite.play("walkingDown")
		Vector2i.LEFT:
			facing = "left"
			sprite.play("walkingLeft")
		Vector2i.RIGHT:
			facing = "right"
			sprite.play("walkingRight")
	var tween = create_tween()
	tween.tween_property(self, "position", self.position + Vector2(direction) * 64, 0.2).set_trans(Tween.TRANS_SINE)
	tween.play()
	walking = true
	tilePosition += direction
	moveTimer.start()

func backwardMove(direction : Vector2i):
	match direction:
		Vector2i.UP:
			facing = "down"
			sprite.play("walkingDown")
		Vector2i.DOWN:
			facing = "up"
			sprite.play("walkingUp")
		Vector2i.LEFT:
			facing = "right"
			sprite.play("walkingRight")
		Vector2i.RIGHT:
			facing = "left"
			sprite.play("walkingLeft")
	var tween = create_tween()
	tween.tween_property(self, "position", self.position + Vector2(direction) * 64, 0.2).set_trans(Tween.TRANS_SINE)
	tween.play()
	walking = true
	tilePosition += direction
	moveTimer.start()

func turn(direction : Vector2i):
	match direction:
		Vector2i.UP:
			facing = "up"
		Vector2i.DOWN:
			facing = "down"
		Vector2i.LEFT:
			facing = "left"
		Vector2i.RIGHT:
			facing = "right"
	sprite.play(facing)

func _on_move_timer_timeout():
	walking = false
	sprite.play(facing)

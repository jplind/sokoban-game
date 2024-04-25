extends CanvasLayer

signal  levelSelected(level)

func _ready():
	pass

func _process(delta):
	pass

func _on_level_1_button_pressed():
	emit_signal("levelSelected", 1)

func _on_level_2_button_pressed():
	emit_signal("levelSelected", 2)

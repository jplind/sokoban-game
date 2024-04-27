extends AnimationPlayer

func _ready():
	fade_in()

func fade_in():
	play("fade_in")

func fade_out():
	play("fade_out")

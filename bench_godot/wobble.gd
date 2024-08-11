class_name Logo
extends Sprite2D

var age := 0.0

var transformMatrix := Transform2D()

func _ready():
	var scale = 0.364
	transformMatrix = transformMatrix.scaled_local(Vector2(scale, scale))
	transformMatrix = transformMatrix.translated(Vector2(960 * 0.4, 600 * 0.12))

func _process(delta):
	age += delta
	
	transform = transformMatrix.rotated_local(sin(age / 2) * 0.05)

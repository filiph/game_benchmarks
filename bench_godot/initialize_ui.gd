extends Control

func _ready():
	var button_resource = load("res://disappearing_button.tscn")
	for i in range(20):
		var button = button_resource.instantiate() as Button
		button.text = "Button %d" % (i + 1)
		button.position.x = 700
		button.position.y = 30 + i * 22
		add_child(button)

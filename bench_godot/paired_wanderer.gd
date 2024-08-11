class_name PairedWanderer
extends Node2D

var other_wanderer : PairedWanderer

var velocity := Vector2(150, 10)

var world_size := Vector2(960, 600)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
	
	if (other_wanderer != null):
		position += other_wanderer.velocity * delta * 0.25
		
	if position.x < 0 && velocity.x < 0:
		velocity.x = -velocity.x
	elif position.x > world_size.x && velocity.x > 0:
		velocity.x = -velocity.x
	if position.y < 0 && velocity.y < 0:
		velocity.y = -velocity.y
	elif position.y > world_size.y && velocity.y > 0:
		velocity.y = -velocity.y

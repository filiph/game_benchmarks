extends Node2D

static var batch_size = 100;

var wanderers: Array[PairedWanderer] = []

func _ready():
	seed(42)
	pass

func add_batch():
	assert(batch_size % 2 == 0)
	var world_size = Vector2(960, 600) # get_tree().root.size
	var paired_wanderer_resource = load("res://paired_wanderer.tscn")
	for i in range(batch_size / 2):
		var a := paired_wanderer_resource.instantiate() as PairedWanderer
		a.velocity = Vector2(randf_range(-0.5, 0.5) * 100, randf_range(-0.5, 0.5) * 100)
		a.world_size = world_size
		a.position = Vector2(randf() * world_size.x, randf() * world_size.y)
		var b := paired_wanderer_resource.instantiate() as PairedWanderer
		b.velocity = Vector2(randf_range(-0.5, 0.5) * 100, randf_range(-0.5, 0.5) * 100)
		b.world_size = world_size
		b.position = Vector2(randf() * world_size.x, randf() * world_size.y)
		b.other_wanderer = b
		b.other_wanderer = a
		add_child(a)
		add_child(b)
		wanderers.append(a)
		wanderers.append(b)
	
func remove_batch():
	if wanderers.is_empty():
		print('Cannot remove from empty list.')
		return
	
	for i in range(wanderers.size() - batch_size, wanderers.size()):
		wanderers[i].queue_free()
		
	wanderers.resize(wanderers.size() - batch_size)

extends Marker2D

@export var spawnTimeout : float = 0.5
@export var rotational : int = 10
@export var max_spawned = 20
@export var spawn_duration = 10
var fragmentBullets = preload("res://bullets/fragment_bullet.tscn")
@export var fragImage = preload("res://bullets/6_pointed_star_bullet.png")
@export var internalFragment = preload("res://bullets/fragment_bullet.tscn")
var spawned_number = 0


func init_fragment():
	spawned_number += 1
	var newFragmentBullet = fragmentBullets.instantiate()
	newFragmentBullet.spriteImage = fragImage
	newFragmentBullet.fragment_count = 6
	newFragmentBullet.child_scene = internalFragment
	newFragmentBullet.global_position = global_position
	newFragmentBullet.direction = newFragmentBullet.direction.rotated(spawned_number * rotational)
	get_parent().add_child(newFragmentBullet)


func _ready() -> void:
	# if spawn_duration is greater than 0:
	# set timer to delete this spawner after some time
	if spawn_duration > 0:
		spawn_duration_checker()
	# We can also restrict the number of things spawned by this spanwer
	while spawned_number < max_spawned:
		init_fragment()
		await get_tree().create_timer(spawnTimeout).timeout
	queue_free()


func spawn_duration_checker():
	await get_tree().create_timer(spawn_duration).timeout
	queue_free()

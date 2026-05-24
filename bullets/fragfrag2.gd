extends Projectile
class_name FragFragBullet

@export var timeout_duration : float
@export var fragment_count : int
@export var freeze_duration : float
@export var child_scene = load("res://bullets/frag_bullet.tscn")

func initBullet() -> void:
	# Wait before splitting
	await get_tree().create_timer(timeout_duration).timeout
	
	move = false
	
	await get_tree().create_timer(freeze_duration).timeout
	
	
	var childBullets = []
	# initialize all bullets
	for f in range(fragment_count):
		var newBullet = child_scene.instantiate()
		childBullets.append(newBullet)
		newBullet.direction = direction.rotated(deg_to_rad(360.0/fragment_count * f))
		newBullet.scale /= 2
	
	# add all bullets
	for childFragment in childBullets:
		childFragment.global_position = global_position
		get_parent().add_child(childFragment)

	disable()

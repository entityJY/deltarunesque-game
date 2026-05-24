extends Marker2D

## Timeout between waves
@export var spawnTimeout : float = 5
## Number of bullets to spawn in one wave
@export var waveCount : int = 5
## Determines if range restriction local to one bullet or full wave
@export var wave_rotation_local : bool = false
## Number of degrees to rotate spawned bullets in between each wave
@export var rotational : int = 10
## Range in which things can spawn
@export var spawn_range : Vector2 = Vector2(0, 360)
## True if you want it to switch directions when it hits the end of the range
@export var pan_enabled : bool = false
## Max number of bullets that can be spawned by this spawner
@export var max_spawned = 0
## How long to spawn bullets for
@export var spawn_duration = 10
## List of bullets to spawn, cycles through
@export var bullets = [preload("res://bullets/base_bullet.tscn"), preload("res://bullets/triangleBullet.tscn")]
## Specific settings for bullets
@export var bulletInitSettings = [{}]
## 1 for clockwise, -1 for counterclockwise
@export var rot_dir = 1

## Number of spawned bullets
var spawned_number = 0
## Number of spawned waves
var spawned_waves = 0


func bullet_init_settings(bullet_index : int, wave_index : int):
	var newBullet = bullets[bullet_index].instantiate()
	# Set all parameters as provided
	if bullet_index < len(bulletInitSettings):
		# Setting basic bullet parameters
		var current_settings : Dictionary = bulletInitSettings[bullet_index]
		if current_settings.has("speed"):
			newBullet.speed = current_settings["speed"]
		if current_settings.has("damage"):
			newBullet.damage = current_settings["damage"]
		if current_settings.has("spriteImage"):
			newBullet.spriteImage = load(current_settings["spriteImage"])
		if current_settings.has("direction"):
			newBullet.direction = current_settings["direction"]
		
		# AccelerationBullet-specific settings
		if current_settings.has("acceleration") and newBullet is AccelerationBullet:
			newBullet.acceleration = current_settings["acceleration"]
			
		# ArrowProjectile-specific settings
		if current_settings.has("spin") and newBullet is ArrowProjectile:
			newBullet.spin = current_settings["spin"]
		if current_settings.has("child_scene") and newBullet is ArrowProjectile:
			newBullet.child_scene = current_settings["child_scene"]
		if current_settings.has("spawnDelay") and newBullet is ArrowProjectile:
			newBullet.spawnDelay = current_settings["spawnDelay"]
		
		# BouncingBullet-specific settings
		if current_settings.has("bounce_counter") and newBullet is BouncingBullet:
			newBullet.bounce_counter = current_settings["bounce_counter"]

		# FragmentBullet-specific settings
		if current_settings.has("timeout_duration") and newBullet is FragmentBullet:
			newBullet.timeout_duration = current_settings["timeout_duration"]
		if current_settings.has("fragment_count") and newBullet is FragmentBullet:
			newBullet.fragment_count = current_settings["fragment_count"]
		if current_settings.has("freeze_duration") and newBullet is FragmentBullet:
			newBullet.freeze_duration = current_settings["freeze_duration"]
		if current_settings.has("child_scene") and newBullet is FragmentBullet:
			newBullet.child_scene = load(current_settings["child_scene"])
	
	# Set position and direction, add to tree
	newBullet.global_position = global_position
	
	var new_rotation = (spawned_waves * rotational)
	

	new_rotation += wave_index * ((spawn_range.x - spawn_range.y) / waveCount)
	new_rotation = int(new_rotation) % int(spawn_range.x - spawn_range.y)
	
	# Makes the waves move left to right and right to left
	if pan_enabled:
		var rotTimes :int = floori((spawned_waves * rotational) / (spawn_range.x - spawn_range.y))
		if rotTimes % 2 != 0:
			if rot_dir == 1:
				new_rotation = spawn_range.y - new_rotation
			else:
				new_rotation = spawn_range.x + new_rotation
		else:
			if rot_dir == -1:
				new_rotation = spawn_range.y - new_rotation
			else:
				new_rotation = spawn_range.x + new_rotation
	else:
		if rot_dir == -1:
			new_rotation = spawn_range.y - new_rotation
		else:
			new_rotation = spawn_range.x + new_rotation

	if wave_rotation_local:
		new_rotation += wave_index * ( 360.0 / waveCount)

	newBullet.direction = newBullet.direction.rotated(deg_to_rad(new_rotation))
	#newBullet.scale = Vector2(0.1, 0.1)
	get_parent().add_child(newBullet)
	spawned_number += 1

func _ready() -> void:
	# if spawn_duration is greater than 0:
	# set timer to delete this spawner after some time
	if spawn_duration > 0:
		spawn_duration_checker()
	# if max_spawned == 0:
	# spawn infinitely
	if max_spawned == 0:
		max_spawned = INF
	# We can also restrict the number of things spawned by this spanwer
	while spawned_number < max_spawned:
		await get_tree().create_timer(spawnTimeout).timeout
		# We can spawn multiple bullets at once in a wave
		for nBullet in range(0, waveCount):
			bullet_init_settings(spawned_number % len(bullets), nBullet)
			spawned_waves += 1
	queue_free()


func spawn_duration_checker():
	await get_tree().create_timer(spawn_duration).timeout
	queue_free()

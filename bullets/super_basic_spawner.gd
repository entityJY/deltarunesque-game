extends Marker2D

## Timeout between waves
@export var spawnTimeout : float = 5
## Number of bullets to spawn in one wave
@export var waveCount : int = 5
## Number of degrees to rotate spawned bullets in between each wave
@export var rotational : int = 10
## Range in which things can spawn
@export var spawnRange : Vector2 = Vector2(0, 360)
## Range in which things can rotate
@export var rotationRange : Vector2 = Vector2(0, 360)
## True if you want it to switch directions when it hits the end of the range
@export var panEnabled : bool = false
## Max number of bullets that can be spawned by this spawner
@export var maxSpawned = 0
## How long to spawn bullets for
@export var spawnDuration = 10
## List of bullets to spawn, cycles through
@export var bullets = [preload("res://bullets/base_bullet.tscn"), preload("res://bullets/triangleBullet.tscn")]
## Specific settings for bullets
@export var bulletInitSettings = [{}]
## 1 for clockwise, -1 for counterclockwise
@export var rotDir = 1
## Scale of bullets
@export var bulletScale = Vector2(0.1, 0.1)
## Set player character if you want it to target player
@export var playerChar : Player
## Toggle to disable autorun
@export var manualMode = false

@export var onreadySpawn = false

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
	
	if playerChar == null:
		var new_rotation = calc_rot(0, spawnRange, wave_index)
		
		var spawner_rot = spawned_waves * rotational
		@warning_ignore("narrowing_conversion")
		# this is desired behavior (because we need it for the modulo) so don't worry about it
		spawner_rot = (spawner_rot % absi(rotationRange.y - rotationRange.x))
		
		# Makes the waves move left to right and right to left
		if panEnabled:
			var rotTimes :int = floori((spawned_waves * rotational) / (rotationRange.y - rotationRange.x))
			if rotTimes % 2 != 0:
				if rotDir == 1:
					spawner_rot = rotationRange.y - spawner_rot
				else:
					spawner_rot = rotationRange.x + spawner_rot
			else:
				if rotDir == -1:
					spawner_rot = rotationRange.y - spawner_rot
				else:
					spawner_rot = rotationRange.x + spawner_rot
		else:
			if rotDir == -1:
				spawner_rot = rotationRange.y - spawner_rot
			else:
				spawner_rot = rotationRange.x + spawner_rot

		newBullet.direction = newBullet.direction.rotated(deg_to_rad(new_rotation)).rotated(deg_to_rad(spawner_rot)).rotated(rotation)
	else:
		newBullet.direction = global_position.direction_to(playerChar.global_position)
		var spacer = (abs(spawnRange.y - spawnRange.x) /( waveCount - 1))
		var spawner_rot = -abs(spawnRange.y - spawnRange.x)/2 + (spacer * wave_index)
		if abs(spawnRange.y - spawnRange.x) >= 360 :
			spacer = (abs(spawnRange.y - spawnRange.x) / waveCount)
			spawner_rot = (spacer * wave_index)

		#print(-abs(spawnRange.y - spawnRange.x)/2, " vs ", spacer)
		newBullet.direction = newBullet.direction.rotated(deg_to_rad(spawner_rot))
		
	
	newBullet.scale = bulletScale
	get_parent().add_child(newBullet)
	spawned_number += 1

func _ready() -> void:
	if onreadySpawn:
		start_spawning()

func calc_rot(new_rotation, local_spawnRange, wave_index):
	if abs(local_spawnRange.y - local_spawnRange.x) != 360:
		new_rotation += wave_index * ((local_spawnRange.y - local_spawnRange.x) / (waveCount - 1))

		if new_rotation > (local_spawnRange.y - local_spawnRange.x):
			new_rotation = int(new_rotation) % int(local_spawnRange.y - local_spawnRange.x)
	else:
		new_rotation += wave_index * (360.0 / (waveCount))
		new_rotation = int(new_rotation) % int(360)

	if rotDir == -1:
		new_rotation = local_spawnRange.y - new_rotation
	else:
		new_rotation = local_spawnRange.x + new_rotation

	return new_rotation
	

func start_spawning() -> void:
	if !manualMode:
		# if spawnDuration is greater than 0:
		# set timer to delete this spawner after some time
		if spawnDuration > 0:
			spawn_duration_checker()
		# if maxSpawned == 0:
		# spawn infinitely
		if maxSpawned == 0:
			maxSpawned = INF
		# We can also restrict the number of things spawned by this spanwer
		while spawned_number < maxSpawned:
			# We can spawn multiple bullets at once in a wave
			for nBullet in range(0, waveCount):
				bullet_init_settings(spawned_number % len(bullets), nBullet)
			spawned_waves += 1
			await get_tree().create_timer(spawnTimeout).timeout
		queue_free()
	else:
		manual_run()
		await get_tree().create_timer(0.1).timeout
		queue_free()

func manual_run():
	for nBullet in range(0, waveCount):
		bullet_init_settings(spawned_number % len(bullets), nBullet)
	spawned_waves += 1

func spawn_duration_checker():
	await get_tree().create_timer(spawnDuration).timeout
	queue_free()

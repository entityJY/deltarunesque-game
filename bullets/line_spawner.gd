extends BasicSpawner

## Timeout between waves
@export var spawnTimeout : float = 5
## Number of bullets to spawn in one wave
@export var waveCount : int = 5
## Max number of bullets that can be spawned by this spawner
@export var maxSpawned = 0
## How long to spawn bullets for
@export var spawnDuration = 10
## List of bullets to spawn, cycles through
@export var bullets = [preload("res://bullets/reversalBullet.tscn")]
## Specific settings for bullets
@export var bulletInitSettings = [{}]
## 1 for right, -1 for left
@export var dir = 1
@export var accDir = 1
@export var lineRange = Vector2(0, 1080)
@export var baseSpeed = 500
@export var speedValues = [1, 1.1, 1.2, 1.1, 1]
@export var baseAcceleration = -4
@export var bulletScale = Vector2(0.1, 0.1)
@export var cycleValues : bool = true


## Number of spawned bullets
var spawned_number = 0
## Number of spawned waves
var spawned_waves = 0

func bullet_init_settings(bullet_index : int, wave_index : int):
	var newBullet = bullets[bullet_index].instantiate()
	
	var position_offset = Vector2(wave_index, wave_index)
	position_offset.x *= lineRange.x / waveCount
	position_offset.x -= lineRange.x / 2.0
	position_offset.y *= lineRange.y / waveCount
	position_offset.y -= lineRange.y / 2.0
	
	# Set position and direction, add to tree
	newBullet.global_position = global_position + position_offset

	newBullet.speed = baseSpeed * speedValues[(wave_index + spawned_waves) % len(speedValues)] * dir
	newBullet.acceleration = baseAcceleration * accDir

	if lineRange.x != 0:
		newBullet.direction =newBullet.direction.rotated()
	newBullet.scale = bulletScale
	get_parent().add_child(newBullet)
	spawned_number += 1

func start_spawning():
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

func spawn_duration_checker():
	await get_tree().create_timer(spawnDuration).timeout
	queue_free()

extends Node2D

@export var player : Player

@export var current_song : AudioStreamPlayer
@export var current_bpm : int = 146
## Beatmap that consists of a list of dictionaries.
## Please keep in mind that no validation of values is done,
## so check on your own, please. Also, the following is required:
## "spawnerType", "position", "time". Note that "playerChar" just
## takes a placeholder value and is set to current player regardless.
var beatmap = []

@export var song_list : Array[AudioStreamPlayer]= []

var loaded_song = {
	"current_song" : 0,
	"current_bpm" : 150,
	"beatmap": [
		{
			"spawnerType": "res://bullets/bullet_spawners/spiral_in_spawner.tscn",
			"spawn_radius": 500,
			"rad_between_bullet": PI/8,
			"rotates_clockwise": true,
			"initial_rad": 0.0,
			"beats_per_bullet": .25,
			"firing_time": 4,
			"bullet_speed": 400,
			"bpm": current_bpm,
			"position": Vector2(1920.0/2, 1080.0/2),
			"time" : 0,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 0,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/spiral_in_spawner.tscn",
			"spawn_radius": 500,
			"rad_between_bullet": PI/8,
			"rotates_clockwise": true,
			"initial_rad": 0.0,
			"beats_per_bullet": .25,
			"firing_time": 4,
			"bullet_speed": 400,
			"bpm": current_bpm,
			"position": Vector2(1920.0/2, 1080.0/2),
			"time" : 4,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 4,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/spiral_in_spawner.tscn",
			"spawn_radius": 500,
			"rad_between_bullet": PI/8,
			"rotates_clockwise": true,
			"initial_rad": 0.0,
			"beats_per_bullet": .25,
			"firing_time": 4,
			"bullet_speed": 400,
			"bpm": current_bpm,
			"position": Vector2(1920.0/2, 1080.0/2),
			"time" : 8,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 8,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/spiral_in_spawner.tscn",
			"spawn_radius": 500,
			"rad_between_bullet": PI/8,
			"rotates_clockwise": true,
			"initial_rad": 0.0,
			"beats_per_bullet": .25,
			"firing_time": 4,
			"bullet_speed": 400,
			"bpm": current_bpm,
			"position": Vector2(1920.0/2, 1080.0/2),
			"time" : 12,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 12,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/spiral_in_spawner.tscn",
			"spawn_radius": 500,
			"rad_between_bullet": PI/8,
			"rotates_clockwise": true,
			"initial_rad": 0.0,
			"beats_per_bullet": .25,
			"firing_time": 4,
			"bullet_speed": 400,
			"bpm": current_bpm,
			"position": Vector2(1920.0/2, 1080.0/2),
			"time" : 16,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 16,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/spiral_in_spawner.tscn",
			"spawn_radius": 500,
			"rad_between_bullet": PI/8,
			"rotates_clockwise": true,
			"initial_rad": 0.0,
			"beats_per_bullet": .25,
			"firing_time": 4,
			"bullet_speed": 400,
			"bpm": current_bpm,
			"position": Vector2(1920.0/2, 1080.0/2),
			"time" : 20,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 20,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/spiral_in_spawner.tscn",
			"spawn_radius": 500,
			"rad_between_bullet": PI/8,
			"rotates_clockwise": true,
			"initial_rad": 0.0,
			"beats_per_bullet": .25,
			"firing_time": 4,
			"bullet_speed": 400,
			"bpm": current_bpm,
			"position": Vector2(1920.0/2, 1080.0/2),
			"time" : 24,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 24,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/spiral_in_spawner.tscn",
			"spawn_radius": 500,
			"rad_between_bullet": PI/8,
			"rotates_clockwise": true,
			"initial_rad": 0.0,
			"beats_per_bullet": .25,
			"firing_time": 4,
			"bullet_speed": 400,
			"bpm": current_bpm,
			"position": Vector2(1920.0/2, 1080.0/2),
			"time" : 28,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 28,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/spiral_in_spawner.tscn",
			"spawn_radius": 500,
			"rad_between_bullet": PI/8,
			"rotates_clockwise": true,
			"initial_rad": 0.0,
			"beats_per_bullet": .25,
			"firing_time": 4,
			"bullet_speed": 400,
			"bpm": current_bpm,
			"position": Vector2(1920.0/2, 1080.0/2),
			"time" : 32,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 32,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/spiral_in_spawner.tscn",
			"spawn_radius": 500,
			"rad_between_bullet": PI/8,
			"rotates_clockwise": true,
			"initial_rad": 0.0,
			"beats_per_bullet": .25,
			"firing_time": 4,
			"bullet_speed": 400,
			"bpm": current_bpm,
			"position": Vector2(1920.0/2, 1080.0/2),
			"time" : 36,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 36,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/spiral_in_spawner.tscn",
			"spawn_radius": 500,
			"rad_between_bullet": PI/8,
			"rotates_clockwise": true,
			"initial_rad": 0.0,
			"beats_per_bullet": .25,
			"firing_time": 4,
			"bullet_speed": 400,
			"bpm": current_bpm,
			"position": Vector2(1920.0/2, 1080.0/2),
			"time" : 40,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 40,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/spiral_in_spawner.tscn",
			"spawn_radius": 500,
			"rad_between_bullet": PI/8,
			"rotates_clockwise": true,
			"initial_rad": 0.0,
			"beats_per_bullet": .25,
			"firing_time": 4,
			"bullet_speed": 400,
			"bpm": current_bpm,
			"position": Vector2(1920.0/2, 1080.0/2),
			"time" : 44,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 44,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/spiral_in_spawner.tscn",
			"spawn_radius": 500,
			"rad_between_bullet": PI/8,
			"rotates_clockwise": true,
			"initial_rad": 0.0,
			"beats_per_bullet": .25,
			"firing_time": 4,
			"bullet_speed": 400,
			"bpm": current_bpm,
			"position": Vector2(1920.0/2, 1080.0/2),
			"time" : 48,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 48,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/spiral_in_spawner.tscn",
			"spawn_radius": 500,
			"rad_between_bullet": PI/8,
			"rotates_clockwise": true,
			"initial_rad": 0.0,
			"beats_per_bullet": .25,
			"firing_time": 4,
			"bullet_speed": 400,
			"bpm": current_bpm,
			"position": Vector2(1920.0/2, 1080.0/2),
			"time" : 52,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 52,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/spiral_in_spawner.tscn",
			"spawn_radius": 500,
			"rad_between_bullet": PI/8,
			"rotates_clockwise": true,
			"initial_rad": 0.0,
			"beats_per_bullet": .25,
			"firing_time": 4,
			"bullet_speed": 400,
			"bpm": current_bpm,
			"position": Vector2(1920.0/2, 1080.0/2),
			"time" : 56,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 56,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"firing_time": 1,
			"position": Vector2(960, 540),
			"time" : 60,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"firing_time": 1,
			"position": Vector2(960, 540),
			"time" : 61,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
			"player": player,
			"firing_time": 1,
			"position": Vector2(960, 540),
			"time" : 62,
		}, # 64
		{
			"spawnerType": "res://bullets/lineSpawner.tscn",
			"spawnTimeout" : 1,
			"position" : Vector2(-950, 86),
			"lineRange" : Vector2(0, 900),
			"baseSpeed" : 850,
			"baseAcceleration" : -10,
			"spawnDuration" : 60,
			"time" : 64
		},
		{
			"spawnerType": "res://bullets/lineSpawner.tscn",
			"spawnTimeout" : 1,
			"position" : Vector2(950, 86),
			"lineRange" : Vector2(0, 900),
			"baseSpeed" : -850,
			"baseAcceleration" : 10,
			"spawnDuration" : 60,
			"time" : 70
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 70,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 74,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 78,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 82,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 86,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 90,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 94,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 98,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 102,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 106,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 110,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 114,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 118,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 122,
		},
		{
			"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
			"player": player,
			"position": Vector2(960, 540),
			"time" : 126,
		},
	]
}

var current_notes = []

var current_note = 0

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	# Attempt to get player
	if player == null:
		player = get_node_or_null("Player")
	
	# Default
	load_song(loaded_song)
	

func load_song(song_data):
	if song_data["current_song"] >= len(song_list):
		print("ERROR: CURRENT SONG NOT IN SONG LIST")
		return
	current_song = song_list[song_data["current_song"]]
	current_bpm = song_data["current_bpm"]
	beatmap = song_data["beatmap"]
	initialize_song()
	

func initialize_song():
	# instance all of the spawners
	for note in beatmap:
		var new_note = load(note["spawnerType"])
		var note_instance = new_note.instantiate()
		current_notes.append(note_instance)
		note_instance.process_mode = Node.PROCESS_MODE_DISABLED
		
		# Setting note parameters
		var current_settings = note

		for property in current_settings.keys():
			if property == "player":
				note_instance.set(property, player)
				continue
			note_instance.set(property, current_settings[property])
		
		note_instance.global_position = current_settings["position"]
		add_child.call_deferred(note_instance)
		await note_instance.tree_entered
	current_song.play()
	await current_song.finished
	# Clear out any remaining spawners that might've de-synced
	for spawner in current_notes:
		if is_instance_valid(spawner):
			spawner.queue_free()

func _process(_delta: float) -> void:
	if current_song and current_song.playing:
		var time = current_song.get_playback_position() + AudioServer.get_time_since_last_mix()
		time -= AudioServer.get_output_latency()
		var beat_duration = 60.0/current_bpm
		if current_note >= len(beatmap):
			return
		# Actually run the spawner
		while time > (beatmap[current_note]["time"] * beat_duration):
			#print(time, " vs ", beatmap[current_note]["time"] * beat_duration)
			current_notes[current_note].process_mode = Node.PROCESS_MODE_INHERIT
			current_notes[current_note].start_spawning()
			current_note += 1
			if current_note >= len(beatmap):
				return

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
			"rad_between_bullet": PI/9,
			"rotates_clockwise": true,
			"initial_rad": 0.0,
			"beats_per_bullet": 1,
			"firing_time": 20,
			"speed": 800,
			"bpm": current_bpm,
			"position": Vector2(1920.0/2, 1080.0/2),
			"time" : 0,
		},
	]
}
var current_notes = []

var current_note = 0

func _ready() -> void:
	await get_tree().create_timer(5).timeout
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

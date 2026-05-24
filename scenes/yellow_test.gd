extends Node2D

@export var current_song : AudioStreamPlayer
@export var current_bpm : int = 150
## Beatmap that consists of a list of dictionaries.
## Please keep in mind that no validation of values is done,
## so check on your own, please. Also, the following is required:
## "spawnerType", "position", "time". Note that "playerChar" just
## takes a placeholder value and is set to current player regardless.
@export var beatmap = [
	{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
	"spawnTimeout" : .4,
	"waveCount" : 1,
	"position" : Vector2(0, 0),
	"spawnDuration" : 48,
	"playerChar" : "",
	"sd" : 300,
	"bulletScale" : Vector2(.05, .05),
	"time" : 0}]
var current_notes = []

var current_note = 0

func _ready() -> void:
	await get_tree().create_timer(5).timeout
	initialize_song()
	

func initialize_song():
	var i = 0
	# instance all of the spawners
	for note in beatmap:
		var new_note = load(note["spawnerType"])
		var note_instance = new_note.instantiate()
		current_notes.append(note_instance)
		note_instance.process_mode = Node.PROCESS_MODE_DISABLED
		
		# Setting note parameters
		var current_settings : Dictionary = beatmap[i]
		
		if current_settings.has("spawnTimeout"):
			note_instance.spawnTimeout = current_settings["spawnTimeout"]
			
		if current_settings.has("waveCount"):
			note_instance.waveCount = current_settings["waveCount"]
		
		if current_settings.has("rotational"):
			note_instance.rotational = current_settings["rotational"]
		
		if current_settings.has("rotation"):
			note_instance.rotation = current_settings["rotation"]
		
		if current_settings.has("spawnRange"):
			note_instance.spawnRange = current_settings["spawnRange"]
		
		if current_settings.has("rotationRange"):
			note_instance.rotationRange = current_settings["rotationRange"]
		
		if current_settings.has("panEnabled"):
			note_instance.panEnabled = current_settings["panEnabled"]
		
		if current_settings.has("maxSpawned"):
			note_instance.maxSpawned = current_settings["maxSpawned"]
			
		if current_settings.has("spawnDuration"):
			note_instance.spawnDuration = current_settings["spawnDuration"]
		
		if current_settings.has("playerChar"):
			note_instance.playerChar = $Player
		
		if current_settings.has("manualMode"):
			note_instance.manualMode = current_settings["manualMode"]

		if current_settings.has("lineRange"):
			note_instance.lineRange = current_settings["lineRange"]
			
		if current_settings.has("bullets"):
			note_instance.bullets = current_settings["bullets"]
			
		if current_settings.has("bulletInitSettings"):
			note_instance.bulletInitSettings = current_settings["bulletInitSettings"]
			
		if current_settings.has("baseSpeed"):
			note_instance.baseSpeed = current_settings["baseSpeed"]
		
		if current_settings.has("dir"):
			note_instance.dir = current_settings["dir"]
		
		if current_settings.has("rotDir"):
			note_instance.rotDir = current_settings["rotDir"]
		
		if current_settings.has("accDir"):
			note_instance.accDir = current_settings["accDir"]
		
		if current_settings.has("baseAcceleration"):
			note_instance.baseAcceleration = current_settings["baseAcceleration"]
		
		if current_settings.has("speedValues"):
			note_instance.speedValues = current_settings["speedValues"]
		
		if current_settings.has("bulletScale"):
			note_instance.bulletScale = current_settings["bulletScale"]
		
		if current_settings.has("cycleValues"):
			note_instance.cycleValues = current_settings["cycleValues"]
			
		if current_settings.has("sd"):
			note_instance.sd = current_settings["sd"]
		
		note_instance.global_position = current_settings["position"]
		add_child.call_deferred(note_instance)
		await note_instance.tree_entered
		i += 1
	current_song.play()
	await current_song.finished
	# Clear out any remaining spawners that might've de-synced
	for spawner in current_notes:
		if is_instance_valid(spawner):
			spawner.queue_free()

func _process(_delta: float) -> void:
	if current_song.playing:
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

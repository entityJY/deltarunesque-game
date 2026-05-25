extends Node2D

@export var player : Player

var songChoices = [1, 4]
var stages_played = 0

@export var current_song : AudioStreamPlayer
@export var current_bpm : int = 146
## Beatmap that consists of a list of dictionaries.
## Please keep in mind that no validation of values is done,
## so check on your own, please. Also, the following is required:
## "spawnerType", "position", "time". Note that "playerChar" just
## takes a placeholder value and is set to current player regardless.
@export var beatmap = []

@export var song_list : Array[AudioStreamPlayer]= []

var song_maps = [
	{},
	# ORANGE
	{"current_song" : 1,
"current_bpm" : 146,
"beatmap": 
	[
	{"spawnerType": "res://bullets/lineSpawner.tscn",
	"spawnTimeout" : 1.2,
	"position" : Vector2(-950, 86),
	"lineRange" : Vector2(0, 900),
	"baseSpeed" : 800,
	"baseAcceleration" : -10,
	"spawnDuration" : 34,
	"time" : 0},
	{"spawnerType": "res://bullets/lineSpawner.tscn",
	"spawnTimeout" : 1.2,
	"position" : Vector2(950, 86),
	"lineRange" : Vector2(0, 900),
	"baseSpeed" : -800,
	"baseAcceleration" : 10,
	"spawnDuration" : 34,
	"time" : 8},
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"spawnTimeout" : 2.4,
	"position" : Vector2(-380, -380),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 9.86,
	"time" : 16},
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"spawnTimeout" : 2.4,
	"position" : Vector2(380, -380),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 4.93,
	"time" : 20},
	{"spawnerType": "res://bullets/panning_sweep_spawner.tscn",
	"spawnTimeout" : 0.205479,
	"position" : Vector2(0, -540),
	"rotation" : deg_to_rad(15),
	"rotational": 20,
	"spawnDuration" : 9.86,
	"rotDir" : -1,
	"time" : 32},
	{"spawnerType": "res://bullets/panning_sweep_spawner.tscn",
	"spawnTimeout" : 0.205479,
	"position" : Vector2(0, -540),
	"rotational": 20,
	"bulletInitSettings" : [{"speed": 100}],
	"rotation" : deg_to_rad(30),
	"spawnDuration" : 4.93,
	"rotDir" : 1,
	"time" : 48},
	# Cymbals
	{"spawnerType": "res://bullets/explosionSpawner.tscn",
	"spawnTimeout" : 10,
	"position" : Vector2(960, -540),
	"spawnDuration" : 4.93,
	"bulletScale" : Vector2(0.2, 0.2),
	"bulletInitSettings" : [{"speed": 400}],
	"manualMode" : true,
	"playerChar" : "",
	"time" : 72.5},
	{"spawnerType": "res://bullets/explosionSpawner.tscn",
	"spawnTimeout" : 10,
	"position" : Vector2(-960, -540),
	"spawnDuration" : 4.93,
	"bulletScale" : Vector2(0.2, 0.2),
	"bulletInitSettings" : [{"speed": 400}],
	"manualMode" : true,
	"playerChar" : "",
	"time" : 73},
	{"spawnerType": "res://bullets/explosionSpawner.tscn",
	"spawnTimeout" : 10,
	"position" : Vector2(960, -540),
	"spawnDuration" : 4.93,
	"bulletScale" : Vector2(0.2, 0.2),
	"bulletInitSettings" : [{"speed": 400}],
	"manualMode" : true,
	"playerChar" : "",
	"time" : 74},
	{"spawnerType": "res://bullets/explosionSpawner.tscn",
	"spawnTimeout" : 10,
	"position" : Vector2(-960, -540),
	"spawnDuration" : 4.93,
	"bulletScale" : Vector2(0.2, 0.2),
	"bulletInitSettings" : [{"speed": 400}],
	"manualMode" : true,
	"playerChar" : "",
	"time" : 74.5},
	{"spawnerType": "res://bullets/explosionSpawner.tscn",
	"spawnTimeout" : 10,
	"position" : Vector2(960, -540),
	"spawnDuration" : 4.93,
	"bulletScale" : Vector2(0.2, 0.2),
	"bulletInitSettings" : [{"speed": 400}],
	"manualMode" : true,
	"playerChar" : "",
	"time" : 75.5},
	{"spawnerType": "res://bullets/explosionSpawner.tscn",
	"spawnTimeout" : 10,
	"position" : Vector2(-960, -540),
	"spawnDuration" : 4.93,
	"bulletScale" : Vector2(0.2, 0.2),
	"bulletInitSettings" : [{"speed": 400}],
	"manualMode" : true,
	"playerChar" : "",
	"time" : 76.5},
	{"spawnerType": "res://bullets/explosionSpawner.tscn",
	"spawnTimeout" : 10,
	"position" : Vector2(960, -540),
	"spawnDuration" : 4.93,
	"bulletScale" : Vector2(0.2, 0.2),
	"bulletInitSettings" : [{"speed": 400}],
	"manualMode" : true,
	"playerChar" : "",
	"time" : 77.5},
	{"spawnerType": "res://bullets/explosionSpawner.tscn",
	"spawnTimeout" : 10,
	"position" : Vector2(-960, -540),
	"spawnDuration" : 4.93,
	"bulletScale" : Vector2(0.2, 0.2),
	"bulletInitSettings" : [{"speed": 400}],
	"manualMode" : true,
	"playerChar" : "",
	"time" : 78},
	
	{"spawnerType": "res://bullets/explosionSpawner.tscn",
	"spawnTimeout" : 10,
	"waveCount" : 1,
	"position" : Vector2(-960, 0),
	"spawnDuration" : 4.93,
	"bulletInitSettings" : [{"speed": 600}],
	"manualMode" : true,
	"time" : 79},
	{"spawnerType": "res://bullets/explosionSpawner.tscn",
	"spawnTimeout" : 10,
	"waveCount" : 1,
	"position" : Vector2(960, 0),
	"spawnDuration" : 4.93,
	"bulletInitSettings" : [{"speed": 600}],
	"manualMode" : true,
	"time" : 79.25},
	{"spawnerType": "res://bullets/explosionSpawner.tscn",
	"spawnTimeout" : 10,
	"waveCount" : 1,
	"position" : Vector2(-960, 0),
	"spawnDuration" : 4.93,
	"bulletInitSettings" : [{"speed": 600}],
	"manualMode" : true,
	"time" : 79.5},
	{"spawnerType": "res://bullets/explosionSpawner.tscn",
	"spawnTimeout" : 10,
	"waveCount" : 1,
	"position" : Vector2(960, 0),
	"spawnDuration" : 4.93,
	"bulletInitSettings" : [{"speed": 600}],
	"manualMode" : true,
	"time" : 79.75},
	
]},
{},
{},

# BLUE
{"current_song" : 4,
"current_bpm" : 100,
"beatmap": 
	[
	{"spawnerType": "res://bullets/bubble_spawner.tscn",
	#"spawnTimeout" : 1.2,
	"position" : Vector2(-960, 540),
	"rotation" : deg_to_rad(-100),
	"spawnDuration" : 4.8,
	"time" : 0},
	{"spawnerType": "res://bullets/bubble_spawner.tscn",
	#"spawnTimeout" : 1.2,
	"position" : Vector2(960, -540),
	"rotation" : deg_to_rad(100),
	"spawnDuration" : 4.8,
	"time" : 0},
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(-960, 0),
	"spawnDuration" : 2.3,
	"time" : 0},
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(960, 0),
	"rotation" : deg_to_rad(180),
	"spawnDuration" : 2.3,
	"time" : 16},
	{"spawnerType": "res://bullets/bubble_spawner.tscn",
	#"spawnTimeout" : 1.2,
	"position" : Vector2(960, 540),
	"rotation" : deg_to_rad(200),
	"spawnDuration" : 4.8,
	"time" : 16},
	{"spawnerType": "res://bullets/bubble_spawner.tscn",
	#"spawnTimeout" : 1.2,
	"position" : Vector2(-960, -540),
	"rotation" : deg_to_rad(40),
	"spawnDuration" : 4.8,
	"time" : 16},
	
	# wow cascade
	{"spawnerType": "res://bullets/bubble_spawner.tscn",
	#"spawnTimeout" : 1.2,
	"position" : Vector2(-960, 270),
	"rotation" : deg_to_rad(-120),
	"spawnDuration" : 0,
	"time" : 32},
	{"spawnerType": "res://bullets/bubble_spawner.tscn",
	#"spawnTimeout" : 1.2,
	"position" : Vector2(-960, -270),
	"rotation" : deg_to_rad(-120),
	"spawnDuration" : 0,
	"time" : 32},
	
	# wow cascade
	{"spawnerType": "res://bullets/bubble_spawner.tscn",
	#"spawnTimeout" : 1.2,
	"position" : Vector2(960, 270),
	"rotation" : deg_to_rad(70),
	"spawnDuration" : 0,
	"time" : 32},
	{"spawnerType": "res://bullets/bubble_spawner.tscn",
	#"spawnTimeout" : 1.2,
	"position" : Vector2(960, -270),
	"rotation" : deg_to_rad(70),
	"spawnDuration" : 0,
	"time" : 32},
	
	# piano
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(-960, 540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 9.86,
	"manualMode": true,
	"time" : 32},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(960, 0),
	"rotation" : deg_to_rad(180),
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"spawnDuration" : 1,
	"time" : 33},
	
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(960, -540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 4.93,
	"manualMode": true,
	"time" : 33.5},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(-960, 0),
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"spawnDuration" : 1.4,
	"time" : 34},
	
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(960, 540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 4.93,
	"manualMode": true,
	"time" : 34.25},
	
	# piano measure 2
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(-960, -540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 9.86,
	"manualMode": true,
	"time" : 36},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(-960, 0),
	"spawnDuration" : 1,
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"time" : 37},
	
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(-960, 540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 4.93,
	"manualMode": true,
	"time" : 37.5},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(960, 0),
	"rotation" : deg_to_rad(180),
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"spawnDuration" : 1,
	"time" : 38},
	
	# piano measure 3
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(-960, -540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 9.86,
	"manualMode": true,
	"time" : 40},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(-960, 0),
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"spawnDuration" : 1,
	"time" : 41},
	
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(960, 540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 4.93,
	"manualMode": true,
	"time" : 42.5},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(960, 0),
	"rotation" : deg_to_rad(180),
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"spawnDuration" : 1,
	"time" : 43},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(-960, 0),
	"spawnDuration" : 1,
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"time" : 43.75},
	
	# piano measure 4
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(-960, 540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 9.86,
	"manualMode": true,
	"time" : 44},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(-960, 0),
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"spawnDuration" : 1,
	"time" : 45},
	
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(960, -540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 4.93,
	"manualMode": true,
	"time" : 45.5},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(960, 0),
	"rotation" : deg_to_rad(180),
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"spawnDuration" : 1,
	"time" : 46},
	
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(-960, 540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 4.93,
	"manualMode": true,
	"time" : 46.75},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(-960, 0),
	"spawnDuration" : 1,
	"bulletInitSettings": [{"bounce_counter": 2, "speed" : 1600}],
	"time" : 46.75},
	
	
	# repeat
	
	# piano
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(-960, 540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 9.86,
	"manualMode": true,
	"time" : 32 + 16},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(960, 0),
	"rotation" : deg_to_rad(180),
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"spawnDuration" : 1,
	"time" : 33 + 16},
	
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(960, -540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 4.93,
	"manualMode": true,
	"time" : 33.5 + 16},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(-960, 0),
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"spawnDuration" : 1.4,
	"time" : 34 + 16},
	
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(960, 540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 4.93,
	"manualMode": true,
	"time" : 34.25 + 16},
	
	# piano measure 2
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(-960, -540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 9.86,
	"manualMode": true,
	"time" : 36 + 16},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(-960, 0),
	"spawnDuration" : 1,
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"time" : 37 + 16},
	
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(-960, 540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 4.93,
	"manualMode": true,
	"time" : 37.5 + 16},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(960, 0),
	"rotation" : deg_to_rad(180),
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"spawnDuration" : 1,
	"time" : 38 + 16},
	
	# piano measure 3
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(-960, 540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 9.86,
	"manualMode": true,
	"time" : 40 + 16},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(-960, 0),
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"spawnDuration" : 1,
	"time" : 41 + 16},
	
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(-960, 540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 4.93,
	"manualMode": true,
	"time" : 42.5 + 16},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(960, 0),
	"rotation" : deg_to_rad(180),
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"spawnDuration" : 1,
	"time" : 43 + 16},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(-960, 0),
	"spawnDuration" : 1,
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"time" : 43.75 + 16},
	
	# piano measure 4
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(-960, 540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 9.86,
	"manualMode": true,
	"time" : 44 + 16},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(-960, 0),
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"spawnDuration" : 1,
	"time" : 45+ 16},
	
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"spawnTimeout" : 2.4,
	"waveCount" : 10,
	"position" : Vector2(960, -540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 4.93,
	"manualMode": true,
	"time" : 45.5+ 16},
	
	{"spawnerType": "res://bullets/bouncer_spawner.tscn",
	"position" : Vector2(960, 0),
	"rotation" : deg_to_rad(180),
	"bulletInitSettings": [{"bounce_counter": 0, "speed" : 800}],
	"spawnDuration" : 1,
	"time" : 46+ 16},
	
	{"spawnerType": "res://bullets/spreadshot_spawner.tscn",
	"waveCount" : 10,
	"spawnTimeout" : 2.4,
	"position" : Vector2(-960, 540),
	"spawnRange" : Vector2(0, 120),
	"playerChar" : '',
	"spawnDuration" : 4.93,
	"manualMode": true,
	"time" : 46.75+ 16},

]}
]

var loaded_song = {}
var current_notes = []
var current_note = 0

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	# Attempt to get player
	if player == null:
		player = get_node_or_null("Player")
	
	## Default
	get_next_song()
	
	
func get_next_song():
	if stages_played % len(songChoices) == 0:
		songChoices.shuffle()
	var currentStage = songChoices[stages_played % len(songChoices)]
	$CanvasModulate.stageSwap(currentStage)
	load_song(song_maps[currentStage])
	await song_list[currentStage].finished
	print("it done")
	stages_played += 1
	get_next_song()

func load_song(song_data):
	if song_data["current_song"] >= len(song_list):
		print("ERROR: CURRENT SONG NOT IN SONG LIST")
		return
	current_song = song_list[song_data["current_song"]]
	current_bpm = song_data["current_bpm"]
	beatmap = song_data["beatmap"]
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
		
		if current_settings.has("playerChar") and player:
			note_instance.playerChar = player
		
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

extends Node2D

@export var player : Player
## list of AudioStreams for levels to use
@export var song_list : Array[AudioStreamPlayer]= []
## the color switcher for the level
@export var canvas_modulate: LevelColorSwitcher

## list of possible levels to load, len = len(song_maps)
var songChoices: Array[int] = [0, 1, 2, 3, 4]
## the current stage to load
var stages_played: int = 0

## Beatmap that consists of a list of dictionaries.
## Please keep in mind that no validation of values is done,
## so check on your own, please. Also, the following is required:
## "spawnerType", "position", "time". Note that "playerChar" just
## takes a placeholder value and is set to current player regardless.

## list of possible levels to play
## [codeblock]
## Array[
## 	Dictionary{
## 		"current_song": int,
## 		"current_bpm": 150, 
## 		"beatmap": Array[Dictionary]
## 	}
## ]
## [/codeblock]
var song_maps = [
	# RED
	{
		"current_song" : 0,
		"current_bpm" : 150,
		"beatmap": [
			{
				"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
				"beats_per_laser": 2,
				"firing_time": 59,
				"warning_beats": .9,
				"flash_time": .1,
				"cooldown_timeout": 5,
				"laser_duration": .1,
				"laser_width": 80,
				"player": null,
				"bpm": 150,

				"position": Vector2(960, 540),
				"audio_stream": null,
				"time" : 0,
			},
			{
				"spawnerType": "res://bullets/bullet_spawners/spiral_in_spawner.tscn",
				"spawn_radius": 500,
				"rad_between_bullet": PI/8,
				"rotates_clockwise": true,
				"initial_rad": 0.0,
				"beats_per_bullet": .25,
				"firing_time": 52,
				"bullet_speed": 400,
				"bullet_radius": 40,
				"bpm": 150,
				
				"position": Vector2(1920.0/2, 1080.0/2),
				"audio_stream": null,
				"time" : 8,
			},
			{
				"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
				"beats_per_laser": 2,
				"firing_time": 1,
				"warning_beats": 3,
				"flash_time": .1,
				"cooldown_timeout": 5,
				"laser_duration": .1,
				"laser_width": 160,
				"player": null,
				"bpm": 150,

				"position": Vector2(960, 540),
				"audio_stream": null,
				"time" : 60,
			},
			{
				"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
				"beats_per_laser": 2,
				"firing_time": 1,
				"warning_beats": 2,
				"flash_time": .1,
				"cooldown_timeout": 5,
				"laser_duration": .1,
				"laser_width": 160,
				"player": null,
				"bpm": 151,

				"position": Vector2(960, 540),
				"audio_stream": null,
				"time" : 61,
			},
			{
				"spawnerType": "res://bullets/bullet_spawners/random_laser_spawner.tscn",
				"beats_per_laser": 2,
				"firing_time": 1,
				"warning_beats": 1,
				"flash_time": .1,
				"cooldown_timeout": 5,
				"laser_duration": .1,
				"laser_width": 160,
				"player": null,
				"bpm": 150,

				"position": Vector2(960, 540),
				"audio_stream": null,
				"time" : 62,
			},
			{
				"spawnerType": "res://bullets/lineSpawner.tscn",
				"spawnTimeout" : 1,
				"position" : Vector2(-950, 86),
				"lineRange" : Vector2(0, 900),
				"baseSpeed" : 800,
				"waveCount": 10,
				"baseAcceleration" : -10,
				"spawnDuration" : 0,
				"time" : 64
			},
			{
				"spawnerType": "res://bullets/lineSpawner.tscn",
				"spawnTimeout" : 1,
				"position" : Vector2(950, 86),
				"lineRange" : Vector2(0, 900),
				"baseSpeed" : -800,
				"waveCount": 10,
				"baseAcceleration" : 10,
				"spawnDuration" : 0,
				"time" : 72
			},
			{
				"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
				"beats_per_laser": 2,
				"firing_time": 62,
				"warning_beats": 1,
				"flash_time": .1,
				"cooldown_timeout": 5,
				"laser_duration": .1,
				"laser_width": 160,
				"bpm": 151,

				"position": Vector2(960, 540),
				"audio_stream": null,
				"time" : 64,
			},
			{
				"spawnerType": "res://bullets/bullet_spawners/random_laser_horizontal.tscn",
				"beats_per_laser": 2,
				"firing_time": 62,
				"warning_beats": 1,
				"flash_time": .1,
				"cooldown_timeout": 5,
				"laser_duration": .1,
				"laser_width": 160,
				"bpm": 151,

				"position": Vector2(960, 540),
				"audio_stream": null,
				"time" : 100,
			},
		]
	},
	# ORANGE
	{
		"current_song" : 1,
		"current_bpm" : 146,
		"beatmap": [
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
		]
	},
	# YELLOW
	{
		"current_song" : 2,
		"current_bpm" : 160,
		"beatmap": 
			[{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"spawnTimeout" : .375,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 48,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 90,
			"time" : 0}, 
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/arrow_bullet.tscn")],
			"bulletInitSettings": [{"speed" : 600}],
			"spawnTimeout" : 6,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 20,
			"playerChar" : "",
			#"rotation" : 90,
			"sd" : 100,
			"bulletScale" : Vector2(.1, .1),
			"rotational" : 90,
			#"manualMode" : true,
			"time" : 10}, 
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/frag_bullet.tscn")],
			"bulletInitSettings": [{"speed" : 800}],
			"spawnTimeout" : .75,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 4,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.1, .1),
			"rotational" : 90,
			"time" : 16},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/frag_bullet.tscn")],
			"bulletInitSettings": [{"speed" : 800}],
			"spawnTimeout" : .75,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 4,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.1, .1),
			"rotational" : 90,
			"time" : 32},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/frag_bullet.tscn")],
			"bulletInitSettings": [{"speed" : 800}],
			"spawnTimeout" : .75,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 4,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.1, .1),
			"rotational" : 90,
			"time" : 48},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/frag_bullet.tscn")],
			"bulletInitSettings": [{"speed" : 800}],
			"spawnTimeout" : .375,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 0,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.1, .1),
			"rotational" : 90,
			"time" : 64},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/arrow_bullet.tscn"), load("res://bullets/arrow_bullet.tscn"), load("res://bullets/arrow_bullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200}, {"speed" : 1200}, {"speed" : 600}],
			"spawnTimeout" : 3,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 8,
			"playerChar" : "",
			#"rotation" : 90,
			"sd" : 100,
			"bulletScale" : Vector2(.1, .1),
			"rotational" : 90,
			#"manualMode" : true,
			"time" : 71},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/arrow_bullet.tscn"), load("res://bullets/arrow_bullet.tscn"), load("res://bullets/arrow_bullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200}, {"speed" : 1200}, {"speed" : 600}],
			"spawnTimeout" : 3,
			"waveCount" : 2,
			"position" : Vector2(0, 0),
			"spawnDuration" : 8,
			"playerChar" : "",
			#"rotation" : 90,
			"sd" : 100,
			"bulletScale" : Vector2(.1, .1),
			"rotational" : 90,
			#"manualMode" : true,
			"time" : 103}
		]
	},
	# GREEN
	{
		"current_song" : 3,
		"current_bpm" : 97,
		"beatmap": 
			[{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .6186,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 1.5,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 180,
			"time" : 0},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .3093,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : .4,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 0,
			"rotation" : PI,
			"time" : 3},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .6186,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 1.5,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 180,
			"time" : 4},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .3093,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : .4,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 0,
			"rotation" : PI,
			"time" : 7},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .6186,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 1.5,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 180,
			"time" : 8},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .3093,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : .4,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 0,
			"rotation" : PI,
			"time" : 11},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .6186,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 1.5,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 180,
			"time" : 12},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .3093,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : .4,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 0,
			"rotation" : PI,
			"time" : 15},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/frag_frag_bullet.tscn")],
			"bulletInitSettings": [{"speed" : 200}],
			"spawnTimeout" : 2.4742,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 17,
			"playerChar" : "",
			"rotation" : 3*PI/2,
			"sd" : 250,
			"bulletScale" : Vector2(.3, .3),
			"rotational" : 180,
			#"manualMode" : true,
			"time" : 16},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .6186,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 1.5,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 180,
			"time" : 16},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .3093,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : .4,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 0,
			"rotation" : PI,
			"time" : 19},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .6186,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 1.5,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 180,
			"time" : 20},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .3093,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : .4,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 0,
			"rotation" : PI,
			"time" : 23},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .6186,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 1.5,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 180,
			"time" : 24},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .3093,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : .4,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 0,
			"rotation" : PI,
			"time" : 27},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .6186,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 1.5,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 180,
			"time" : 28},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .3093,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : .4,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 0,
			"rotation" : PI,
			"time" : 31},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .6186,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 1.5,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 180,
			"time" : 32},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .3093,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : .4,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 0,
			"rotation" : PI,
			"time" : 35},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .6186,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 1.5,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 180,
			"time" : 36},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .3093,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : .4,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 0,
			"rotation" : PI,
			"time" : 39},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .6186,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 1.5,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 180,
			"time" : 40},
			
			{"spawnerType": "res://bullets/normal_dist_spawner.tscn",
			"bullets" : [load("res://bullets/reversalBullet.tscn")],
			"bulletInitSettings": [{"speed" : 1200, "acceleration" : -10}],
			"spawnTimeout" : .6186,
			"waveCount" : 1,
			"position" : Vector2(0, 0),
			"spawnDuration" : 1.5,
			"playerChar" : "",
			"sd" : 250,
			"bulletScale" : Vector2(.07, .07),
			"rotational" : 180,
			"rotation" : PI,
			"time" : 44},
		
		]
	},
	# BLUE
	{
		"current_song" : 4,
		"current_bpm" : 100,
		"beatmap": [
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
		]
	}
]

## list of spawners to load on specific beats
var beatmap: Array = []
## spawners that have already been created for the song
var current_notes: Array[Variant] = []
## the current note in beatmap, used an index through the beatmap
var current_note: int = 0
## the current song playing
var current_song: AudioStreamPlayer
## the bpm of the current song
var current_bpm: int = 146

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	# Attempt to get player
	if player == null:
		player = get_node_or_null("Player")
	if canvas_modulate == null:
		canvas_modulate = get_node_or_null("CanvasModulate")
	
	# Default
	get_next_song()
	
	
func get_next_song():
	var currentStage = songChoices[stages_played % len(songChoices)]
	canvas_modulate.stageSwap(currentStage)
	
	load_song(song_maps[currentStage])
	

func load_song(song_data: Dictionary):
	if stages_played % len(songChoices) == 0:	# check if player has played through all the levels
		songChoices.shuffle()
	current_note = 0
	current_notes.clear()
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
		# create new spawner, add to current_notes
		var new_note = load(note["spawnerType"])
		var note_instance = new_note.instantiate()
		current_notes.append(note_instance)
		note_instance.process_mode = Node.PROCESS_MODE_DISABLED
		
		# Setting note parameters
		for property in note.keys():
			if property == "player" or property == "playerChar":
				note_instance.set(property, player)
				continue
			if property == "audio_stream":
				note_instance.set(property, current_song)
				continue
			note_instance.set(property, note[property])
		
		# move spawner to its specified spawn position
		note_instance.global_position = note["position"]

		# add spawner as a child
		add_child.call_deferred(note_instance)
		await note_instance.tree_entered
	
	print("Song playing: " + current_song.name)
	current_song.play()

	await current_song.finished

	# Clear out any remaining spawners that might've de-synced
	for spawner in current_notes:
		if is_instance_valid(spawner):
			spawner.queue_free()
	current_notes = []

	stages_played += 1
	get_next_song()

func _process(_delta: float) -> void:
	if current_song and current_song.playing:
		if current_note >= len(current_notes):
			return
		if !is_instance_valid(current_notes[current_note]):
			return
		
		var time = current_song.get_playback_position() + AudioServer.get_time_since_last_mix()
		time -= AudioServer.get_output_latency()

		var beat_duration = 60.0/current_bpm
		
		# Actually run the spawner
		while time > (beatmap[current_note]["time"] * beat_duration):
			current_notes[current_note].start_spawning()
			current_note += 1
			if current_note >= len(beatmap):
				break

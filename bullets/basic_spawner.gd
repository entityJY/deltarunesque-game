extends Marker2D
class_name BasicSpawner

## how long a beat of the song lasts for
@export var bpm: float
## the audio stream being played
@export var audio_stream: AudioStreamPlayer
## what beat the spawner starts firing
@export var time: float
## beats between each bullet firing
@export var beats_per_spawn: float
## how many beats the spawner runs for
@export var spawn_duration: float

var spawning_enabled: bool = false
var next_spawn_time: float

## called when spawner is enabled
func start_spawning():
	spawning_enabled = true

func _process(_delta: float) -> void:
	if !spawning_enabled: return

	var song_beat = (audio_stream.get_playback_position() + AudioServer.get_time_since_last_mix()) * bpm / 60.0 - time
	if spawn_duration > 0 and song_beat > spawn_duration:
		queue_free()
		return
	
	if song_beat > next_spawn_time:
		spawn_projectile()
		next_spawn_time += beats_per_spawn

## run when the spawner tries to spawn a projectile/group of projectiles
func spawn_projectile():
	pass

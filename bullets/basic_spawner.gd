extends Marker2D
class_name BasicSpawner

## how long a beat of the song lasts for
@export var bpm: float
## the audio stream being played
@export var audio_stream: AudioStreamPlayer
## what beat the spawner starts firing
@export var time: float

func start_spawning():
	pass

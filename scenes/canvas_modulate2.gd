extends CanvasModulate
class_name LevelColorSwitcher

@export var tracks: Array[AudioStream] = []
#@export var stages: = [null, preload("res://scenes/orange_scene.tscn"), null, null, null]
@export var fadeTime = 2.0
@export var fadeDB = -20.0
@export var player : Player
var stage := 0
var tween: Tween
@export var prevPlayer : AudioStreamPlayer
@export var nextPlayer : AudioStreamPlayer
var isCurrPlayer1 : bool = true
var swapping : bool = false
var activeStage = null

#signal old_track_ended
#signal new_track_started

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:	
	##audioPlayer1 = $"../AudioPlayer1"
	##audioPlayer2 = $"../AudioPlayer2"
	#
	#stageSwap()
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	#if Input.is_action_just_pressed("nextStage"):
		#stageSwap()
		
	#if prevPlayer and prevPlayer.stream != null and prevPlayer.playing:
		#if (prevPlayer.stream.get_length() - prevPlayer.get_playback_position()) < fadeTime and !swapping:
			#swapping = true
			#old_track_ended.emit()
			
	#if audioPlayer2.stream != null and audioPlayer2.playing:
		#if (audioPlayer2.stream.get_length() - audioPlayer2.get_playback_position()) < fadeTime and !swapping:
			#swapping = true
			#stageSwap();
			#
	pass

## changes the color of the stage, 0: RED, 1: ORANGE, 2: YELLOW, 3: GREEN, 4: AQUA
func stageSwap(stageSelect: int):
	var targetColor
	stage = stageSelect
	match stage:
		0:
			targetColor = Color.RED
			nextPlayer = get_parent().get_node("Red")
			
		1:
			targetColor = Color.DARK_ORANGE
			nextPlayer = get_parent().get_node("Orange")
			
		2: 
			targetColor = Color.YELLOW
			nextPlayer = get_parent().get_node("Yellow")
			
		3:
			targetColor = Color.LIME_GREEN
			nextPlayer = get_parent().get_node("Green")
			
		4: 
			targetColor = Color.AQUA
			nextPlayer = get_parent().get_node("Blue")
	if tween:
		tween.kill()
			
	tween = create_tween()
	tween.tween_property(self, "color", targetColor, fadeTime)

	#if isCurrPlayer1:
		#newPlayer = audioPlayer2
		#prevPlayer = audioPlayer1
	#isCurrPlayer1 = !isCurrPlayer1
		
	#nextPlayer.stream = tracks[stage]
	nextPlayer.volume_db = fadeDB
	nextPlayer.play()
	#new_track_started.emit()
	
	var audioIn = create_tween()
	
	audioIn.tween_property(nextPlayer, "volume_db", 0.0, fadeTime)
	if prevPlayer:
		var audioOut = create_tween()
		audioOut.tween_property(prevPlayer, "volume_db", fadeDB, fadeTime)
	
	prevPlayer = nextPlayer
	nextPlayer = null
	
	#if stages[stage] != null:
		#activeStage = stages[stage].instantiate()
		#get_parent().add_child.call_deferred(activeStage)
		#activeStage.global_position = global_position
		#activeStage.player = player
	
	#await get_tree().create_timer(fadeTime).timeout
	#
	#stopTrack(prevPlayer)
	
#func stopTrack(songPlayer):
	#songPlayer.stop()
	#swapping = false

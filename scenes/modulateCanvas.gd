extends CanvasModulate

@export var tracks: Array[AudioStream] = []
#@export var stages: = [null, preload("res://scenes/orange_scene.tscn"), null, null, null]
@export var fadeTime = 2.0
@export var fadeDB = -20.0
@export var player : Player
var stage := 0
var tween: Tween
var audioPlayer1 : AudioStreamPlayer2D
var audioPlayer2 : AudioStreamPlayer2D
var isCurrPlayer1 : bool = true
var swapping : bool = false
var activeStage = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	audioPlayer1 = $"../AudioPlayer1"
	audioPlayer2 = $"../AudioPlayer2"
	
	stageSwap()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("nextStage"):
		stageSwap()
		
	if audioPlayer1.stream != null and audioPlayer1.playing:
		if (audioPlayer1.stream.get_length() - audioPlayer1.get_playback_position()) < fadeTime and !swapping:
			swapping = true
			stageSwap();
			
	if audioPlayer2.stream != null and audioPlayer2.playing:
		if (audioPlayer2.stream.get_length() - audioPlayer2.get_playback_position()) < fadeTime and !swapping:
			swapping = true
			stageSwap();
			
	pass
	
func stageSwap():
	var targetColor
	var prevStage = stage
	while stage == prevStage:	
		stage = randi_range(0, 4)
		#stage = 1
	
	match stage:
		0:
			targetColor = Color.RED
			
		1:
			targetColor = Color.DARK_ORANGE
			
		2: 
			targetColor = Color.YELLOW
			
		3:
			targetColor = Color.LIME_GREEN
			
		4: 
			targetColor = Color.BLUE
			
	if tween:
		tween.kill()
			
	tween = create_tween()
	tween.tween_property(self, "color", targetColor, fadeTime)
	
	var newPlayer = audioPlayer1
	var prevPlayer = audioPlayer2
	if isCurrPlayer1:
		newPlayer = audioPlayer2
		prevPlayer = audioPlayer1
	isCurrPlayer1 = !isCurrPlayer1
		
	newPlayer.stream = tracks[stage]
	newPlayer.volume_db = fadeDB
	newPlayer.play()
	var audioIn = create_tween()
	var audioOut = create_tween()
	audioIn.tween_property(newPlayer, "volume_db", 0.0, fadeTime)
	audioOut.tween_property(prevPlayer, "volume_db", fadeDB, fadeTime)
	
	#if stages[stage] != null:
		#activeStage = stages[stage].instantiate()
		#get_parent().add_child.call_deferred(activeStage)
		#activeStage.global_position = global_position
		#activeStage.player = player
	
	await get_tree().create_timer(fadeTime).timeout
	
	stopTrack(prevPlayer)
	
func stopTrack(player):
	player.stop()
	swapping = false

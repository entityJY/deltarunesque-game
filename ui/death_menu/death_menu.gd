extends CanvasLayer

@export var button_sfx: AudioStreamPlayer
@export var container: PanelContainer
@export var score_label: Label
@export_file var main_menu_scene: String
@export_file var play_scene: String
var menu_open: bool = false
var movement_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	pass

func open_menu() -> void:
	if movement_tween:
		movement_tween.kill()
	movement_tween = create_tween()
	movement_tween.tween_property(container, "position:y", 360, .5)

func close_menu() -> void:
	if movement_tween:
		movement_tween.kill()
	movement_tween = create_tween()
	movement_tween.tween_property(container, "position:y", -500, .5)
	

func _on_home_button_pressed() -> void:
	button_sfx.play()
	get_tree().change_scene_to_file(main_menu_scene)

func _on_restart_button_pressed() -> void:
	button_sfx.play()
	get_tree().change_scene_to_file(play_scene)


func _on_player_player_killed(score: int) -> void:
	open_menu()
	score_label.text = "Score: " + str(score)

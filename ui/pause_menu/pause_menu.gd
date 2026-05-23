extends PanelContainer
class_name PauseMenu


@export_file var play_scene: String
var paused: bool = false

signal restart_level


func _ready() -> void:
	hide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		paused = !paused
		if paused:
			get_tree().paused = true
			show()
		else:
			hide()
			get_tree().paused = false

func _on_home_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(play_scene)

func _on_continue_pressed() -> void:
	paused = false
	hide()
	get_tree().paused = false

func _on_restart_pressed() -> void:
	get_tree().paused = false
	hide()
	restart_level.emit()

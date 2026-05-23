extends PanelContainer
class_name PauseMenu


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
	pass # Replace with function body.

func _on_continue_pressed() -> void:
	print("continued pressed")
	hide()
	get_tree().paused = false

func _on_restart_pressed() -> void:
	restart_level.emit()

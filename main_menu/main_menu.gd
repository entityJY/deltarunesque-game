extends Node2D
class_name MainMenu


@export_file var play_scene: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(play_scene)

func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_credits_pressed() -> void:
	pass # Replace with function body.

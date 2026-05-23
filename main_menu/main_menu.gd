extends Node2D
class_name MainMenu


enum menus {
	CREDITS,
	SETTINGS,
}


@export_file var play_scene: String
@export var animation_player: AnimationPlayer
@export var escape_menu_button: Button
var active_menus: Array[menus]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pop_menu()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(play_scene)

func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_credits_pressed() -> void:
	animation_player.play("open_credits")
	active_menus.append(menus.CREDITS)
	escape_menu_button.show()


func pop_menu() -> void:
	var popped_menu = active_menus.pop_back()

	if popped_menu == null:
		return

	if popped_menu == menus.CREDITS:
		animation_player.play("close_credits")
	
	if len(active_menus) == 0:
		escape_menu_button.hide()

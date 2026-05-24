extends PanelContainer
class_name PauseMenu


@export_file var play_scene: String
var paused: bool = false

@export var animation_player: AnimationPlayer
@export var settings_menu: SettingsMenu

var settings_menu_active: bool = false


func _ready() -> void:
	settings_menu.close_settings_menu.connect(settings_closed)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if settings_menu_active:
			settings_menu.close_settings()
			settings_menu_active = false
			return
		
		paused = !paused
		if paused:
			get_tree().paused = true
			animation_player.play("open_pause")
		else:
			animation_player.play("close_pause")
			get_tree().paused = false

func _on_home_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(play_scene)

func _on_continue_pressed() -> void:
	paused = false
	animation_player.play("close_pause")
	get_tree().paused = false

func _on_settings_pressed() -> void:
	settings_menu.open_settings()
	settings_menu_active = true

func settings_closed() -> void:
	settings_menu_active = false

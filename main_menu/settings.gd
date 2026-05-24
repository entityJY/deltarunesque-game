extends PanelContainer
class_name SettingsMenu

@onready var master = AudioServer.get_bus_index("Master")
@export var master_slider: HSlider
@onready var music = AudioServer.get_bus_index("Music")
@export var music_slider: HSlider
@onready var sfx = AudioServer.get_bus_index("SFX")
@export var sfx_slider: HSlider
@onready var ui = AudioServer.get_bus_index("UI")
@export var ui_slider: HSlider

@export var button_sfx: AudioStreamPlayer
@export var animation_player: AnimationPlayer

signal close_settings_menu()


func _ready() -> void:
	load_config()
	update()

## Closes settings menu
func close_settings() -> void:
	save_config()
	animation_player.play("close_settings")
	close_settings_menu.emit()

## Open settings menu
func open_settings() -> void:
	animation_player.play("open_settings")


## Changes master volume.
func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master, linear_to_db(value))
	button_sfx.play()

## Changes music volume.
func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music, linear_to_db(value))
	button_sfx.play()

## Changes SFX volume.
func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx, linear_to_db(value))
	button_sfx.play()

## Changes UI Volume
func _on_ui_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(ui, linear_to_db(value))
	button_sfx.play()


## Updates volume sliders
func update():
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master))
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx))
	ui_slider.value = db_to_linear(AudioServer.get_bus_volume_db(ui))

## Save user settings.
func save_config():
	var config = ConfigFile.new()
	
	config.set_value("Volume", "master", master_slider.value)
	config.set_value("Volume", "music", music_slider.value)
	config.set_value("Volume", "sfx", sfx_slider.value)
	config.set_value("Volume", "ui", ui_slider.value)
		
	config.save("user://settings.cfg")

## Load user settings.
func load_config():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	
	if err != OK:
		AudioServer.set_bus_volume_db(master, linear_to_db(1))
		AudioServer.set_bus_volume_db(music, linear_to_db(0.71))
		AudioServer.set_bus_volume_db(sfx, linear_to_db(0.71))
		AudioServer.set_bus_volume_db(ui, linear_to_db(0.71))
		
	else:
		AudioServer.set_bus_volume_db(master, linear_to_db(config.get_value("Volume","master",1)))
		AudioServer.set_bus_volume_db(music, linear_to_db(config.get_value("Volume","music",0.71)))
		AudioServer.set_bus_volume_db(sfx, linear_to_db(config.get_value("Volume","sfx",0.71)))
		AudioServer.set_bus_volume_db(ui, linear_to_db(config.get_value("Volume","ui",0.71)))
			
	update()


func _on_close_button_pressed() -> void:
	button_sfx.play()
	close_settings()

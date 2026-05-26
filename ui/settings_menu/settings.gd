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

@export_group("Metronome Settings")
@export var metronome: AudioStreamPlayer
@export var indicator_array: Array[TextureRect]
@export var metronome_slider: HSlider
@export var metronome_label: Label

var settings_tween : Tween
var silence = true

var metronome_playing: bool = false

signal close_settings_menu()


func _ready() -> void:
	load_config()
	self.position.y = -1140

func _process(_delta: float) -> void:
	if !metronome_playing:
		return
	var time = fmod(metronome.get_playback_position() + AudioServer.get_time_since_last_mix() + Constants.track_offset, 4.0)
	if time < .1:
		indicator_array[0].size.x = 200
		return
	if time < 1:
		indicator_array[0].size.x = 100
		return
	if time < 1.1:
		indicator_array[1].size.x = 200
		return
	if time < 2:
		indicator_array[1].size.x = 100
		return
	if time < 2.1:
		indicator_array[2].size.x = 200
		return
	if time < 3:
		indicator_array[2].size.x = 100
		return
	if time < 3.1:
		indicator_array[3].size.x = 200
		return
	if time < 4:
		indicator_array[3].size.x = 100
		return
	

func _on_metronome_button_pressed() -> void:
	metronome_playing = !metronome_playing
	if metronome_playing:
		metronome.play()
	else:
		stop_metronome()

func stop_metronome() -> void:
	metronome.stop()
	indicator_array[0].size.x = 100
	indicator_array[1].size.x = 100
	indicator_array[2].size.x = 100
	indicator_array[3].size.x = 100
	metronome_playing = false

func _on_metronome_slider_value_changed(value: float) -> void:
	metronome_label.text = "Music Offset: " + str(int(value * 1000)) + " ms"
	Constants.track_offset = value

## Closes settings menu
func close_settings() -> void:
	save_config()
	stop_metronome()
	if settings_tween:
		settings_tween.kill()
	settings_tween = create_tween()
	settings_tween.tween_property(self, "position:y", -1140, 0.5)
	close_settings_menu.emit()

## Open settings menu
func open_settings() -> void:
	if settings_tween:
		settings_tween.kill()
	settings_tween = create_tween()
	settings_tween.tween_property(self, "position:y", 12.5, 0.5)


## Changes master volume.
func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master, linear_to_db(value))
	if !silence:
		button_sfx.play()

## Changes music volume.
func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music, linear_to_db(value))
	if !silence:
		button_sfx.play()

## Changes SFX volume.
func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx, linear_to_db(value))
	if !silence:
		button_sfx.play()

## Changes UI Volume
func _on_ui_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(ui, linear_to_db(value))
	if !silence:
		button_sfx.play()


## Updates volume sliders
func update():
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master))
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx))
	ui_slider.value = db_to_linear(AudioServer.get_bus_volume_db(ui))
	metronome_slider.value = Constants.track_offset
	silence = false

## Save user settings.
func save_config():
	var config = ConfigFile.new()
	
	config.set_value("Volume", "master", master_slider.value)
	config.set_value("Volume", "music", music_slider.value)
	config.set_value("Volume", "sfx", sfx_slider.value)
	config.set_value("Volume", "ui", ui_slider.value)
	config.set_value("Offset", "offset", metronome_slider.value)
		
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
		Constants.track_offset = config.get_value("Offset", "offset", 0.0)
			
	update()


func _on_close_button_pressed() -> void:
	if !silence:
		button_sfx.play()
	close_settings()


func _on_reset_button_pressed() -> void:
	_on_metronome_slider_value_changed(0)
	metronome_slider.value = 0

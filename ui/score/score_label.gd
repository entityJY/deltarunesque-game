extends CanvasLayer
@export var player: Player
@export var label: Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	label.text = "Points: " + str(player.points)

extends CanvasModulate

var hue: = 1.0
var saturation: = 1.0
var brightness: = 1.0
var alpha: = 1.0
var stage: = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var targetColor
	
	if Input.is_action_just_pressed("nextStage"):
		var prevStage = stage;
		while stage == prevStage:	
			stage = randi_range(1, 5)
		
	match stage:
		1:
			targetColor = Color.RED
			
		2:
			targetColor = Color.DARK_ORANGE
			
		3: 
			targetColor = Color.YELLOW
			
		4:
			targetColor = Color.LIME_GREEN
			
		5: 
			targetColor = Color.BLUE
			
	var tween = create_tween()
	tween.tween_property(self, "color", targetColor, 2.0)
			
	pass

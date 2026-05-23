extends CanvasModulate

var stage := 0
var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	color = Color.RED;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var targetColor
	
	if Input.is_action_just_pressed("nextStage"):
		print("nextStage pressed")
		var prevStage = stage
		while stage == prevStage:	
			stage = randi_range(0, 4)
		
		match stage:
			0:
				targetColor = Color.RED
				
			1:
				targetColor = Color.DARK_ORANGE
				
			2: 
				targetColor = Color.YELLOW
				
			3:
				targetColor = Color.LIME_GREEN
				
			4: 
				targetColor = Color.BLUE
				
		if tween:
			tween.kill()
				
		tween = create_tween()
		tween.tween_property(self, "color", targetColor, 2.0)
			
	pass

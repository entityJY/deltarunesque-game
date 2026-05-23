extends Projectile

@export var spin = .1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _physics_process(delta: float) -> void:
	if move:
		position += direction * speed * delta
		rotation += spin

# Called every frame. 'delta' is the elapsed time since the previous frame.

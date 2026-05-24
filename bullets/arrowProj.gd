extends Projectile
class_name ArrowProjectile

@export var spin = .1
@export var child_scene : String = "res://bullets/base_bullet.tscn"
@export var spawnDelay = 5

var spawnCounter = 0
var childInstance

# Called when the node enters the scene tree for the first time.
func initBullet() -> void:
	childInstance = load(child_scene)
	pass # Replace with function body.
	
func _physics_process(delta: float) -> void:
	if move:
		position += direction * speed * delta
		rotation += spin
		
		if spawnCounter >= spawnDelay:
			var newBullet = childInstance.instantiate()
			newBullet.direction = direction.rotated(rotation)*1.5
			newBullet.global_position = global_position
			get_parent().add_child(newBullet)
			spawnCounter = 0
			
		else: 
			spawnCounter += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.

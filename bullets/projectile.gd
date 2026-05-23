extends Area2D
class_name Projectile

var parent
@export var speed = 200
@export var damage = 1
@export var direction = Vector2(scale.x, 0)
@export var sprite : Sprite2D
var move = true

func _ready() -> void:
	rotation= direction.angle()

func _physics_process(delta: float) -> void:
	if move:
		position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
		# Hurt enemy here
		disable()
		
func disable()-> void:
	move = false
	set_deferred('monitorable', false)
	set_deferred('monitoring', false)
	var tween = get_tree().create_tween()
	tween.tween_property(sprite,"modulate:a", 0, 0.2)
	queue_free()

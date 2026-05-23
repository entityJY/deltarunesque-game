extends Area2D
class_name Projectile

var parent
@export var speed = 200
@export var damage = 1
@export var direction = Vector2(scale.x, 0)
@export var sprite : Sprite2D
@export var spriteImage : Texture2D
var move = true

## Initializes image for bullet and rotation of bullet
func _ready() -> void:
	sprite.texture = spriteImage
	rotation= direction.angle()
	initBullet()
	
## Initialization code (override when inheriting)
func initBullet():
	pass

## Moves the bullet
func _physics_process(delta: float) -> void:
	if move:
		position += direction * speed * delta

## Deals damage upon impact
func _on_body_entered(body: Node2D) -> void:
		# Hurt enemy here
		disable()

## Disable the bullet so you can't double-dip on damages
func disable()-> void:
	move = false
	set_deferred('monitorable', false)
	set_deferred('monitoring', false)
	var tween = get_tree().create_tween()
	tween.tween_property(sprite,"modulate:a", 0, 0.2)
	queue_free()

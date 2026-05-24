extends Area2D
class_name Projectile

var parent
@export var speed : float = 200
@export var damage : int = 1
@export var direction : Vector2 = Vector2(scale.x, 0)
@export var sprite : Sprite2D
@export var spriteImage : Texture2D
var grazed = false
var move = true
var can_hurt = true

## Initializes image for bullet and rotation of bullet
func _ready() -> void:
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)

	if spriteImage != null:
		if sprite == null:
			sprite = $BulletSprite
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
func _on_area_entered(area: Node2D) -> void:
	# Hurt enemy here
	if can_hurt and area.get_parent() is Player:
		can_hurt = false
		area.get_parent().hurt(damage)
		
	disable()

## Disable the bullet so you can't double-dip on damages
func disable()-> void:
	can_hurt = false
	move = false
	set_deferred('monitorable', false)
	set_deferred('monitoring', false)
	var tween = get_tree().create_tween()
	tween.tween_property(sprite,"modulate:a", 0, 0.2)
	queue_free()

func _on_body_entered(_body : Node2D):
	disable()

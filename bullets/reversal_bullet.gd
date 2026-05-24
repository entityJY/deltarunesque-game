extends Projectile
class_name AccelerationBullet

@export var acceleration : float = -5

func _physics_process(delta: float) -> void:
	if move:
		position += direction * speed * delta
		speed += acceleration

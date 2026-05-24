extends Projectile
class_name BouncingBullet
@export var bounce_counter : int = 5

func _on_body_entered(_body : Node2D):
	if bounce_counter > 0:
		bounce_counter -= 1
		direction *= -1
	elif bounce_counter == 0:
		bounce_counter = -1
		disable()

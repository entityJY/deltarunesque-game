extends Projectile
class_name BouncingBullet
@export var bounce_counter : int = 5

## Deals damage upon impact
func _on_area_entered(area: Node2D) -> void:
	# Hurt enemy here
	if area.get_parent() is Player:
		print("ow")
		area.get_parent().hurt(damage)
	disable()

func _on_body_entered(_body : Node2D):
	if bounce_counter > 0:
		bounce_counter -= 1
		direction *= -1
	else:
		disable()

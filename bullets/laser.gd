extends Area2D
class_name Laser

var cooldown = false
@export var warningTime : float = 3
@export var flashTime : float= 0.1
@export var damage = 1
@export var cooldown_timeout = 0.2
@export var laser_duration : float = 10
@export var laserSize : Vector2 = Vector2(100, 1080)
@export var sprite : Texture2D
## Rotational acceleration in degrees, set to 0 for no rotation
@export var r_acc : float = 0.1
var warningTween : Tween = null
var enabled = false

func _ready() -> void:
	if warningTime > 0:
		$CollisionShape2D.set_deferred("disabled", true)
		warningAnimation()
		await get_tree().create_timer(warningTime).timeout
		warningTween.kill()
		$CollisionShape2D.set_deferred("disabled", false)
	enabled = true
	$WarningSprite.hide()
	$Sprite2D.modulate.a = 1
	$CollisionShape2D.shape.size = laserSize
	await get_tree().create_timer(laser_duration).timeout
	queue_free()

func warningAnimation() -> void:
	$Sprite2D.modulate.a = 0.2
	warningTween = get_tree().create_tween()
	warningTween.set_loops()
	warningTween.tween_property($WarningSprite, "modulate:a", 0.5, flashTime)
	warningTween.tween_property($WarningSprite, "modulate:a", 0, flashTime)

## Damage player if overlapping when not on cooldown
func _physics_process(_delta: float) -> void:
	if enabled:
		if !cooldown:
			var areas = get_overlapping_areas()
			for area in areas:
				if area.get_parent() is Player:
					area.get_parent().hurt(damage)
					handleCooldown()
		rotation_degrees += r_acc


func handleCooldown():
	cooldown = true
	await get_tree().create_timer(cooldown_timeout).timeout
	cooldown = false

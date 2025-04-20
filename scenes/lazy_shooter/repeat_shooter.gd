extends Node2D

@export var bullet_scene: PackedScene
@export var fire_rate: float = 2.5
@export var bullet_speed: float = 1200

var t = 0.0

func _process(dt: float) -> void:
	t += dt
	if t >= time_to_shoot():
		t -= time_to_shoot()
		var curve: Curve2D = $BulletPath.curve
		var d = curve.sample(1, 0) - curve.sample(0, 0)
		d = d.normalized()

		var bullet = bullet_scene.instantiate()
		bullet.global_position = global_position
		bullet.velocity = bullet_speed*d
		get_tree().current_scene.add_child(bullet)

func time_to_shoot() -> float:
	return 1.0 / fire_rate

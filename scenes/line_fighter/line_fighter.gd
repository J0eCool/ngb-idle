extends Node2D

@export var knockback = 100
@export var maxSpeed = 200
@export var accel = 100

var vel = 0

func _physics_process(dt: float) -> void:
	vel += accel*dt
	vel = min(vel, maxSpeed)
	$Hero.position.x += vel*dt

func _on_hero_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		vel = -knockback

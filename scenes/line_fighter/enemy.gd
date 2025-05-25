extends Area2D

@export var max_health = 10

var health = 10

func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		self.queue_free()

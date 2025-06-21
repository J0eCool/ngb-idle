extends Area2D

@export var max_health = 10
@export var xp = 5

@onready var health = max_health

func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		PlayerStats.xp += xp
		self.queue_free()

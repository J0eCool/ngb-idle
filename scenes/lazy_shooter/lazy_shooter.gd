extends Node2D

@export var lightnings: Array[Node2D]

func _on_timer_timeout() -> void:
	for c in self.find_children("Lightning*"):
		c.GenerateSprite()

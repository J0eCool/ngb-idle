extends CharacterBody2D

@export var move_speed: float = 125

func _process(delta: float) -> void:
	var dx = Input.get_axis("left", "right")
	var dy = Input.get_axis("up", "down")
	self.velocity = Vector2(dx, dy)*move_speed
	move_and_slide()

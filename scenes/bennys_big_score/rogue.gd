extends CharacterBody3D

@export var top_speed: float = 2.4

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("enter"):
		$AnimationPlayer.play("1H_Melee_Attack_Chop")

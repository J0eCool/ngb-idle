class_name RoguePlayer
extends CharacterBody3D

@export var top_speed: float = 2.4

func attack() -> void:
	$AnimationPlayer.play("1H_Melee_Attack_Chop")

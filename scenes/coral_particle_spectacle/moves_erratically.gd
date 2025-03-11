class_name MovesErratically
extends Node2D

@export var rotation_amount: float = 100.0
@export var speed: float = 1.0

var t = 0.0
@onready var parent = get_parent()
@onready var original: Transform2D = parent.transform

func _process(dt: float) -> void:
	t += dt
	var rot = deg_to_rad(rotation_amount) * sin(t*speed)
	#var trans = original
	#original.rotated_local(rot)
	parent.transform = original.rotated_local(rot)

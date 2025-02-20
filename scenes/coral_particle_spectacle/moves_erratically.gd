class_name MovesErratically
extends Node2D

@export var rotation_amount: float = 100.0
@export var speed: float = 1.0

var original: Transform2D
var t = 0.0

func _ready() -> void:
	original = get_parent().transform

func _process(dt: float) -> void:
	t += dt
	var rot = deg_to_rad(rotation_amount) * sin(t*speed)
	#var trans = original
	#original.rotated_local(rot)
	get_parent().transform = original.rotated_local(rot)

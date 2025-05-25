extends Node2D

@export var knockback = 100
@export var max_speed = 200
@export var accel = 100
@export var spawn_margin = 100
@export var enemy_scene: PackedScene

var vel = 0
var floor = 1

@onready var spawn_point = $Hero.position.x
@onready var spawnable_area = $Gate.position.x - spawn_point - 2*spawn_margin
@onready var spawned = $Enemies

func _ready() -> void:
	start_floor()

func start_floor() -> void:
	$Hero.position.x = spawn_point
	while spawned.get_child_count() > 0:
		spawned.remove_child(spawned.get_child(0))
	var to_spawn = randi_range(2, 4)

	for i in range(to_spawn):
		var enemy = enemy_scene.instantiate()
		var p = randf_range(0, spawnable_area) + spawn_point+spawn_margin
		enemy.position = Vector2(p, $Hero.position.y)
		# call deferred because this can happen from area_entered,
		# which flushes queries
		spawned.call_deferred("add_child", enemy)

	# Update floor label
	$Label.text = "Floor: {0}".format([floor])

func _physics_process(dt: float) -> void:
	vel += accel*dt
	vel = min(vel, max_speed)
	$Hero.position.x += vel*dt

func _on_hero_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		vel = -knockback
		area.take_damage(4)
	elif area.is_in_group("gateway"):
		floor += 1
		start_floor()

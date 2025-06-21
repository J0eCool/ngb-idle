extends Node2D

@export var knockback = 100
@export var spawn_margin = 100
@export var enemy_scene: PackedScene

var vel = 0
var floor_level = 1 # would be `floor` if that wasn't taken by math

@onready var spawn_point = $Hero.position.x
@onready var spawnable_area = $Gate.position.x - spawn_point - 2*spawn_margin
@onready var spawned = $Enemies

func _ready() -> void:
	start_floor()
	$XP.text = "XP: {0}".format([PlayerStats.xp])

func start_floor() -> void:
	$Hero.position.x = spawn_point
	while spawned.get_child_count() > 0:
		spawned.remove_child(spawned.get_child(0))
	var to_spawn = randi_range(2, 4)

	# cleanup any existing enemies before spawning more
	while spawned.get_child_count() > 0:
		spawned.remove_child(spawned.get_child(0))
	var f = floor_level-1
	for i in range(to_spawn):
		var enemy = enemy_scene.instantiate()
		enemy.max_health = 10 + 3*f
		enemy.xp = 5 + 2*f
		var p = randf_range(0, spawnable_area) + spawn_point+spawn_margin
		enemy.position = Vector2(p, $Hero.position.y)
		# call deferred because this can happen from area_entered,
		# which flushes queries
		spawned.call_deferred("add_child", enemy)

	# Update floor label
	$Floor.text = "Floor: {0}".format([floor_level])

func _physics_process(dt: float) -> void:
	vel += PlayerStats.accel*dt
	vel = min(vel, PlayerStats.max_speed)
	$Hero.position.x += vel*dt

func _on_hero_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		vel = -knockback
		area.take_damage(PlayerStats.damage)
		$XP.text = "XP: {0}".format([PlayerStats.xp])
	elif area.is_in_group("gateway"):
		floor_level += 1
		start_floor()


func _on_to_town_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/line_fighter/town.tscn")

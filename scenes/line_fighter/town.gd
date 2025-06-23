extends Control

@export var damage_increment = 1
@export var speed_increment = 10
@export var accel_increment = 15

func damage_cost() -> int:
	return 5 + 2*(PlayerStats.damage-4)
func speed_cost() -> int:
	return 25 + 2*(PlayerStats.max_speed-200)
func accel_cost() -> int:
	return 50 + 5*(PlayerStats.accel-250)

func _process(delta: float) -> void:
	$XP.text = "XP: {0}".format([PlayerStats.xp])
	$Grid/Damage.text = "Damage: {0}".format([PlayerStats.damage])
	$Grid/BuyDamage.text = "+{0}: {1}xp".format([damage_increment, damage_cost()])
	$Grid/Speed.text = "Max Speed: {0}".format([PlayerStats.max_speed])
	$Grid/BuySpeed.text = "+{0}: {1}xp".format([speed_increment, speed_cost()])
	$Grid/Accel.text = "Acceleration: {0}".format([PlayerStats.accel])
	$Grid/BuyAccel.text = "+{0}: {1}xp".format([accel_increment, accel_cost()])

func _on_to_tower_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/line_fighter/line_fighter.tscn")


func _on_buy_damage_pressed() -> void:
	if PlayerStats.xp >= damage_cost():
		PlayerStats.xp -= damage_cost()
		PlayerStats.damage += damage_increment

func _on_buy_speed_pressed() -> void:
	if PlayerStats.xp >= speed_cost():
		PlayerStats.xp -= speed_cost()
		PlayerStats.max_speed += speed_increment

func _on_buy_accel_pressed() -> void:
	if PlayerStats.xp >= accel_cost():
		PlayerStats.xp -= accel_cost()
		PlayerStats.accel += accel_increment

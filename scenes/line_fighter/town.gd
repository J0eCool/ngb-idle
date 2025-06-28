extends Control

@export var damage_increment = 1
@export var speed_increment = 10
@export var accel_increment = 15

func raw_damage_cost(damage: int) -> int:
	return 5 + 2*(damage-4)
func damage_cost() -> int:
	return raw_damage_cost(PlayerStats.damage)
func bulk_damage_levels(xp_to_spend: int) -> int:
	# quadratic formula baybee
	# we're solving for how-many-levels for a given xp amount
	# probably this only works so cleanly because costs are linear
	var b = damage_cost()
	return (-b + sqrt(b*b + 4*xp_to_spend))/2
func bulk_damage_cost(xp_to_spend: int) -> int:
	var bulk = bulk_damage_levels(xp_to_spend)
	return (raw_damage_cost(PlayerStats.damage-damage_increment) +
		raw_damage_cost(PlayerStats.damage + bulk)) * bulk/2

func speed_cost() -> int:
	return 25 + 2*(PlayerStats.max_speed-200)
func accel_cost() -> int:
	return 50 + 5*(PlayerStats.accel-250)


func _process(_delta: float) -> void:
	var xp = PlayerStats.xp
	$XP.text = "XP: {0}".format([xp])
	$Damage/Label.text = "Damage: {0}".format([PlayerStats.damage])
	$Damage/BuySingle.text = "+{0}: {1}xp".format(
		[damage_increment, damage_cost()])
	$Damage/BuyBulk.text = "+{0}: {1}xp".format(
		[bulk_damage_levels(xp/2), bulk_damage_cost(xp/2)])
	$Speed/Label.text = "Max Speed: {0}".format([PlayerStats.max_speed])
	$Speed/BuySingle.text = "+{0}: {1}xp".format(
		[speed_increment, speed_cost()])
	$Accel/Label.text = "Acceleration: {0}".format([PlayerStats.accel])
	$Accel/BuySingle.text = "+{0}: {1}xp".format(
		[accel_increment, accel_cost()])


func _on_to_tower_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/line_fighter/line_fighter.tscn")


func _on_buy_damage_pressed() -> void:
	if PlayerStats.xp >= damage_cost():
		PlayerStats.xp -= damage_cost()
		PlayerStats.damage += damage_increment

func _on_buy_damage_bulk_pressed() -> void:
	var xp = PlayerStats.xp
	PlayerStats.xp -= bulk_damage_cost(xp/2)
	PlayerStats.damage += damage_increment*bulk_damage_levels(xp/2)

func _on_buy_speed_pressed() -> void:
	if PlayerStats.xp >= speed_cost():
		PlayerStats.xp -= speed_cost()
		PlayerStats.max_speed += speed_increment

func _on_buy_accel_pressed() -> void:
	if PlayerStats.xp >= accel_cost():
		PlayerStats.xp -= accel_cost()
		PlayerStats.accel += accel_increment

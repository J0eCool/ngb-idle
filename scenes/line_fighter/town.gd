extends Control

@export var damage_increment = 1

func damage_cost() -> int:
	return 5 + 2*(PlayerStats.damage-4)

func _process(delta: float) -> void:
	$XP.text = "XP: {0}".format([PlayerStats.xp])
	$Grid/Damage.text = "Damage: {0}".format([PlayerStats.damage])
	$Grid/BuyDamage.text = "+{0}: {1}xp".format([damage_increment, damage_cost()])

func _on_to_tower_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/line_fighter/line_fighter.tscn")


func _on_buy_damage_pressed() -> void:
	if PlayerStats.xp >= damage_cost():
		PlayerStats.xp -= damage_cost()
		PlayerStats.damage += damage_increment

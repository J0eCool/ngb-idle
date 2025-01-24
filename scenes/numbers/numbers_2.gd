extends Control

#const Currency = preload("currency.gd")

# I want to use a CurrencyBank as a reusable currency
# abstraction, but I don't know how to generic that in godot
# So, make it specific

func get_elem(type: Currency.Type) -> Currency:
	for child in $CurrencyBank.get_children():
		if child is Currency and child.type == type:
			return child
	assert(false, "we done goofed")
	return null


func get_currency(type: Currency.Type) -> int:
	return get_elem(type).amount


func gain_currency(type: Currency.Type, amount: int) -> void:
	get_elem(type).amount += amount


func spend_currency(type: Currency.Type, amount: int) -> bool:
	var c = get_elem(type)
	if c.amount >= amount:
		c.amount -= amount
		return true
	return false


func _on_light_button_down() -> void:
	gain_currency(Currency.Type.Light, 1)


func _on_air_button_down() -> void:
	var light = get_currency(Currency.Type.Light)
	if spend_currency(Currency.Type.Light, 2):
		gain_currency(Currency.Type.Air, light)

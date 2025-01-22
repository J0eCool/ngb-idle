@tool
extends Label

enum Type {
	Void=0,
	Light=1,
	Air=2,
	Fire=3,
	Wolf=4,
	Dragon=5,
	Jaguar=6,
	Lightning=7,
	Spider=8,
	Scorpion=9,
}

@export var type: Type
@export var amount: int = 0
@export var limit: int = 0 # 0 = unlimited

func _process(_dt: float) -> void:
	var ty_str = Type.keys()[type]
	var amt_str = amount
	if limit > 0:
		amount = clamp(amount, 0, limit)
		amt_str = "{0} / {1}".format([amount, limit])
	self.text = "{0}: {1}".format([ty_str, amt_str])

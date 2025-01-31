@tool
extends Path2D

func _process(dt: float) -> void:
	# Every frame, update the position of every child along the path

	var childs = self.get_children().filter(
		func(elem): return elem is PathFollow2D)

	if childs.size() == 1:
		# special-case: N=1 isn't distributed, so hardcode
		# its position to the front of the path
		# (maybe make it end-of-path?)
		childs[0].progress_ratio = 0
		return

	# special-case: N=0 makes this a null loop

	var i = 0
	for child in childs:
		child.progress_ratio = float(i)/(childs.size()-1)
		i += 1

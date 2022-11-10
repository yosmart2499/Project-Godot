extends Path2D

func _process(delta):
	$PathFollow2D.unit_offset += 0.1 * delta;

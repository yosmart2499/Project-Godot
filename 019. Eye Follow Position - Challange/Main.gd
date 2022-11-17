extends Node

var mouse_pos: Vector2;

func _process(delta: float) -> void:
	mouse_pos = get_viewport().get_mouse_position();
	var direction: Vector2 = (mouse_pos - $Pivot.position).normalized();
	$Pivot.rotation = direction.angle();

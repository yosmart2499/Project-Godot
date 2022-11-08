extends Node

signal mouse_reset
signal mouse_position(position);

func _process(_delta):
	if(Input.is_action_just_released("mouse_path")):
		emit_signal("mouse_reset");
	if(Input.is_action_pressed("mouse_path")):
		emit_signal("mouse_position", get_viewport().get_mouse_position());

extends Area2D

signal touch

func _on_Raycast_body_entered(body):
	emit_signal("touch");


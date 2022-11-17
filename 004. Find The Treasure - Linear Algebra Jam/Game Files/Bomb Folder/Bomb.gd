extends RigidBody2D

signal bomb_touched

func _on_Bomb_mouse_entered():
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_SINE);
	
	tween.tween_property($BombSprite, "modulate", Color.red, 1);
	tween.tween_property($BombSprite, "modulate", Color.white, 1);
	tween.set_loops(3);
	tween.set_speed_scale(3);
	
	yield(get_tree().create_timer(1), "timeout");
	emit_signal("bomb_touched");
	queue_free();

func deactivate_pickable():
	self.input_pickable = false;

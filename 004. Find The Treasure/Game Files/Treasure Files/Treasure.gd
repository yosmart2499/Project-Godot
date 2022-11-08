extends RigidBody2D

signal treasure_picked;

func _on_Treasure_input_event(viewport, event, shape_idx):
	if(Input.is_action_just_pressed("pick_treasure")):
		var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_SINE);
		tween.tween_property($TreasureSprite, "modulate", Color.greenyellow, 1);
		tween.tween_property($TreasureSprite, "modulate", Color.white, 1);
		tween.set_loops(3);
		tween.set_speed_scale(3);
		
		yield(get_tree().create_timer(1), "timeout");
		emit_signal("treasure_picked");
		queue_free();

func deactivate_pickable():
	self.input_pickable = false;

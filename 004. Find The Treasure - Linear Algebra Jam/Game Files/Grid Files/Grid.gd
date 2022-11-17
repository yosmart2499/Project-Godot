extends RigidBody2D

func _on_Grid_mouse_entered():
	queue_free();

func _on_Grid_body_entered(body):
	queue_free();

func deactivate_pickable():
	self.input_pickable = false;

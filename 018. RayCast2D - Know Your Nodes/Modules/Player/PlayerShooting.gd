extends KinematicBody2D

func _input(event):
	if(event.is_action_pressed("shoot")):
		if($RayCast2D.is_colliding()):
			print($RayCast2D.get_collider().name);

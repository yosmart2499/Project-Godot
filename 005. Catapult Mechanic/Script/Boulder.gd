extends RigidBody2D

var boulder_angle;

func launch_in(pos):
	self.position = pos;

func boulder_velocity(angle, power):
	self.linear_velocity = Vector2(0,-1).rotated(angle) * power;

func _on_BoulderScreenEdgeNotifier_screen_exited():
	self.linear_velocity.x *= -1;
	if(self.position.y <= 0):
		queue_free();


func _on_Area2D_body_entered(body):
	queue_free();

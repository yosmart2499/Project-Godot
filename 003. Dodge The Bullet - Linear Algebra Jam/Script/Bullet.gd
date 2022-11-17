extends RigidBody2D

export (int) var bullet_speed;

func _ready():
#	self.position = get_viewport().size/2;
#	rotateNfire_bullet(2*PI);
	pass;

func rotateNfire_bullet(direction):
#	Why I don't use code below in sniper scene IDK. Maybe when instance it follow what the sniper pointing.
	self.rotation = direction;
	var velocity = Vector2(0, -bullet_speed);
	self.linear_velocity = velocity.rotated(direction);

func _on_VisibilityNotifier2D_screen_exited():
	queue_free();

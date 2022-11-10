extends KinematicBody2D

var gravity: int = 300;
var velocity: Vector2 = Vector2();
var direction: int = 1;
var speed: int = 400;

func _process(delta):
	velocity.y += gravity * delta;
	if(not $RayLeft.is_colliding()):
		direction *= -1;
	if(not $RayRight.is_colliding()):
		direction *= -1;
	velocity.x = direction * speed;
	$Sprite.flip_h = velocity.x > 0;
	print(velocity.y);
	velocity = move_and_slide(velocity, Vector2.UP);
	

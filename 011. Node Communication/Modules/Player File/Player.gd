extends KinematicBody2D

signal pressed_input(input);

var speed: int = 1000;
var velocity: Vector2 = Vector2.ZERO;

func get_input():
	var input_direction: Vector2 = Vector2.ZERO;
	if(Input.is_action_pressed("up")):
		emit_signal("pressed_input", "up");
		input_direction.y -= 1;
	if(Input.is_action_pressed("down")):
		emit_signal("pressed_input", "down");
		input_direction.y += 1;
	if(Input.is_action_pressed("left")):
		emit_signal("pressed_input", "left");
		input_direction.x -= 1;
	if(Input.is_action_pressed("right")):
		emit_signal("pressed_input", "right");
		input_direction.x += 1;
	input_direction.normalized();
	return input_direction;


var face_direction: bool = false;
func _physics_process(_delta):
	var desired_velocity: Vector2 = get_input() * speed;
	velocity.x = desired_velocity.x;
	velocity.y = desired_velocity.y;
	velocity = self.move_and_slide(velocity, Vector2.UP, true);
	
	if(sign(velocity.x) == 0):
		face_direction = face_direction;
	elif(sign(velocity.x) == 1):
		face_direction = false;
	elif(sign(velocity.x) == -1):
		face_direction = true;
	
	$AnimatedSprite.flip_h = face_direction;
	
	if(velocity == Vector2.ZERO):
		$AnimatedSprite.play("stop");
	else:
		$AnimatedSprite.play("run");

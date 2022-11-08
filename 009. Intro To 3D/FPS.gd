extends KinematicBody

onready var camera: Camera = $Pivot/Camera;
var gravity: int =  -30;
var max_speed: int = 8;
var mouse_sensitivity = 0.002;
var velocity: Vector3 = Vector3();

func get_input():
	var input_dir: Vector3 = Vector3();
	if(Input.is_action_pressed("move_forward")):
		input_dir += -global_transform.basis.z;
	if(Input.is_action_pressed("move_backward")):
		input_dir += global_transform.basis.z;
	if(Input.is_action_pressed("strafe_left")):
		input_dir += -global_transform.basis.x;
	if(Input.is_action_pressed("strafe_right")):
		input_dir += global_transform.basis.x;
	input_dir = input_dir.normalized();
	return input_dir;

func _unhandled_input(event):
	if(event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
		self.rotate_y(-event.relative.x * mouse_sensitivity);
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity);
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2);

func _physics_process(delta):
	velocity.y += gravity * delta;
	var desired_velocity: Vector3 = get_input() * max_speed;
	velocity.x = desired_velocity.x;
	velocity.z = desired_velocity.z;
	velocity = move_and_slide(velocity, Vector3.UP, true);
	

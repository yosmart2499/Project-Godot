extends KinematicBody

export (PackedScene) var bullet_scene;

var gravity: Vector3 = Vector3.DOWN * 12;
var speed: int = 4;
var jump_speed: int = 6;
var spin: float = 0.1;
var can_move: bool = true;
var velocity: Vector3 =  Vector3.ZERO;
var jump: bool = false;

func get_input():
	if(!can_move):
		return;
	var vy: float = velocity.y;
	velocity = Vector3();
	if(Input.is_action_pressed("move_forward")):
		if (not self.is_on_floor() or $RayCast.is_colliding()):
			velocity += -self.transform.basis.z * speed;
	if(Input.is_action_pressed("move_backward")):
		velocity += self.transform.basis.z * speed;
	if(Input.is_action_pressed("strafe_right")):
		velocity += self.transform.basis.x * speed;
	if(Input.is_action_pressed("strafe_left")):
		velocity += -self.transform.basis.x * speed;
	velocity.y = vy;
	jump = false;
	if(Input.is_action_just_pressed("jump")):
		jump = true;

func take_damage():
	velocity *= -1;
	velocity.y = jump_speed;
	can_move = false;
	yield(get_tree().create_timer(1), "timeout");
	can_move = true;

func _physics_process(delta):
	velocity += gravity * delta;
	get_input();
	velocity = self.move_and_slide(velocity, Vector3.UP);
	if(jump and self.is_on_floor()):
		velocity.y = jump_speed;

func _unhandled_input(event):
	if(event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
		if(event.relative.x > 0):
			self.rotate_y(-lerp(0, spin, event.relative.x/10));
		elif(event.relative.x < 0):
			self.rotate_y(-lerp(0, spin, event.relative.x/10));
	
	if(event.is_action_pressed("shoot")):
		var bullet = bullet_scene.instance();
		bullet.start($Muzzle.global_transform);
		get_parent().add_child(bullet);

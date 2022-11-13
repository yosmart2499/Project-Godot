extends RigidBody2D

export var engine_thrust: int = 500;
export var spin_thrust: int = 15000;

var thrust: Vector2 = Vector2();
var rotation_dir: int = 0;

onready var screen_size: Vector2 = get_viewport().get_visible_rect().size;

func get_input() -> void:
	if(Input.is_action_pressed("ui_up")):
		self.thrust = self.transform.x * self.engine_thrust;
		print(String(self.transform.x) + " - " + String(self.position.x));
	else:
		self.thrust = Vector2();
	self.rotation_dir = 0;
	if(Input.is_action_pressed("ui_left")):
		self.rotation_dir += 1;
	if(Input.is_action_pressed("ui_right")):
		self.rotation_dir -= 1;

func _process(_delta) -> void:
	self.get_input();

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	self.applied_force = self.thrust
	self.applied_torque = self.rotation_dir * self.spin_thrust
	if(self.position.x > self.screen_size.x):
		state.transform.origin.x = 0
	if(self.position.x < 0):
		state.transform.origin.x = self.screen_size.x
	if(self.position.y > self.screen_size.y):
		state.transform.origin.y = 0
	if(self.position.y < 0):
		state.transform.origin.y = self.screen_size.y

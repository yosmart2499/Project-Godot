extends KinematicBody2D

const vector_i: Vector2 = Vector2.RIGHT;
const vector_j: Vector2 = Vector2.DOWN;

var mouse_position: Vector2 = Vector2();
var difference_vector: Vector2 = Vector2();
var difference_lerp: Vector2 = self.difference_vector;

func _process(delta: float) -> void:
	self.get_input();

func _physics_process(delta: float) -> void:
	if(self.difference_lerp.length() >= self.difference_vector.length() - 2):
		self.difference_vector = Vector2.ZERO;
	self.difference_lerp = self.difference_lerp.linear_interpolate(self.difference_vector, 0.3) * delta;
	print(" - Lerp - ");
	print(self.difference_lerp);
	print(" - Vector - ");
	print(self.difference_vector)

func get_input() -> void:
	if(Input.is_action_just_pressed("left_click")):
		self.mouse_position = self.get_viewport().get_mouse_position();
		self.difference_vector = self.mouse_position - self.position;
	self.position += (vector_i * self.difference_lerp) + (vector_j * self.difference_lerp);

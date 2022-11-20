extends KinematicBody2D

const vector_i: Vector2 = Vector2.RIGHT;
const vector_j: Vector2 = Vector2.DOWN;

var mouse_position: Vector2 = Vector2();
var difference_vector: Vector2 = Vector2();

func _process(delta: float) -> void:
	self.get_input(delta);

func get_input(delta) -> void:
	if(Input.is_action_just_pressed("left_click")):
		self.mouse_position = self.get_viewport().get_mouse_position();
		self.difference_vector = self.mouse_position - self.position;
		yield(self.create_tween().tween_property(self, "position", self.position + self.vector_i * self.difference_vector, 0.3), "finished");
		yield(self.create_tween().tween_property(self, "position", self.position + self.vector_j * self.difference_vector, 0.3), "finished");

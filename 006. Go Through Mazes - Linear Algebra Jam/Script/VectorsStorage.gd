extends Node

var sets_vectors_direction = [];

func _on_Controller_up():
	sets_vectors_direction.append(Vector2(0, -1));

func _on_Controller_down():
	sets_vectors_direction.append(Vector2(0, 1));

func _on_Controller_right():
	sets_vectors_direction.append(Vector2(1, 0));

func _on_Controller_left():
	sets_vectors_direction.append(Vector2(-1, 0));

func adjust_vector_set(scalar):
	if(sets_vectors_direction.empty()):
		return;
	
	for i in range(sets_vectors_direction.size()):
		sets_vectors_direction[i] *= scalar;

func reset_vector_set():
	sets_vectors_direction = [];

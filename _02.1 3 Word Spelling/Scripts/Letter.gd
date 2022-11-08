extends Area2D

var letter_text;

signal letter_touched;

func set_letter_label(text):
	letter_text = text;
	$LetterLabel.text = text;

func toggle_input():
	$CollisionShape2D.set_deferred("disabled", false);

func _on_Letter_input_event(_viewport, _event, _shape_idx):
	if(Input.is_action_pressed("mouse_path")):
		emit_signal("letter_touched", letter_text);
		$CollisionShape2D.set_deferred("disabled", true);

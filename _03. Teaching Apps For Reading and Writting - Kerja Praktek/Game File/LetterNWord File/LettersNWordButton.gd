extends Node2D

var button_text = "";

signal pressed_text(text);

func change_button_text(text):
	button_text = text;
	$TextSpellingButton.text = button_text;

func _on_Button_pressed():
	emit_signal("pressed_text", button_text);

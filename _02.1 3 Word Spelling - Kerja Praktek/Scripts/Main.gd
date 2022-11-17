extends Node

var screen_size;

func _ready():
	screen_size = get_viewport().size;
	$"4LetterDragSystem".create_4letter_path_system("POOL");
	$"4LetterDragSystem".position = screen_size / 2;


func _on_4LetterDragSystem_word_confirmned(word):
	if(word == ""):
		return;
	$HUD.change_wordlabel(word);
	$HUD.waiting_letter_reset = true;
	$HUD/KeyboardWaitingInputTimer.start();
	yield(get_tree().create_timer(2), "timeout");
	$HUD.change_wordlabel("");

func _on_MouseController_mouse_position(position):
	$MousePathLine.add_point(position);

func _on_MouseController_mouse_reset():
	yield(get_tree().create_timer(1), "timeout");
	$MousePathLine.clear_points();

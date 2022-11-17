extends Node

var screen_size;
var selected_level;

signal chosen_level(level);

func _ready():
	selected_level = -1;
	screen_size = get_viewport().size;
#	$SelectedLevel1.connect("level_selected", self, "play_selected_level");
#	$SelectedLevel2.connect("level_selected", self, "play_selected_level");

func change_text_message(message):
	$MessageLabel.text = message;

func _on_StartButton_pressed():
	$MessageLabel.hide();
	$StartButton.text = "Select Level!";
	$SelectedLevel1.change_position(Vector2(screen_size.x/4, screen_size.y/2 - 100));
	$SelectedLevel2.change_position(Vector2(screen_size.x - screen_size.x/4, screen_size.y/2 - 100));
	if(selected_level != -1):
		$SelectedLevel1.hide();
		$SelectedLevel2.hide();
		$MessageLabel.show();
		$StartButton.hide();
		$MessageLabel.text = "Find The Word!";
		yield(get_tree().create_timer(2), "timeout");
		$MessageLabel.hide();
		emit_signal("chosen_level", selected_level - 1);

func play_selected_level(level):
	selected_level = level;

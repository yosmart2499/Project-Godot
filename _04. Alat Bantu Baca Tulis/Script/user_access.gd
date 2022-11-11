extends Node

enum Category{STUDENT, TEACHER};
enum Scene{CHOOSE_FEATURE, ADD_EDIT_DELETE, DISPLAY_GRAPHEME_LIST, DISPLAY_GRAPHEME_ITEM, GRAPHEME_FORM};

var user_type: int = -1;
var screen_type: int = -1;

signal user_selected();
signal change_screen();

func set_user(type: int) -> void:
	self.user_type = type;
	emit_signal("user_selected");

func set_screen(type: int) -> void:
	self.screen_type = type;
	emit_signal("change_screen");

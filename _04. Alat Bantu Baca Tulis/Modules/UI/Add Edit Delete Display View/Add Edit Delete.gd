extends Control

func _ready():
	$UserLabel.text = "Teacher";
	$VBoxContainer/FirstBtn.text = "Add";
	$VBoxContainer/SecondBtn.text = "Change";
	$VBoxContainer/ThirdBtn.text = "Delete"


func _on_FirstBtn_pressed():
	UserAccess.set_mode(UserAccess.Mode.ADD);
	UserAccess.set_screen(UserAccess.Scene.GRAPHEME_FORM);

func _on_SecondBtn_pressed():
	UserAccess.set_mode(UserAccess.Mode.CHANGE);
	UserAccess.set_screen(UserAccess.Scene.DISPLAY_GRAPHEME_LIST);

func _on_ThirdBtn_pressed():
	UserAccess.set_mode(UserAccess.Mode.DELETE);
	UserAccess.set_screen(UserAccess.Scene.DISPLAY_GRAPHEME_LIST);

extends Control

func _ready():
	if(UserAccess.user_type == UserAccess.Category.STUDENT):
		$UserLabel.text = "Student";
		$VBoxContainer/FirstBtn.text = "Games";
		$VBoxContainer/SecondBtn.text = "Spelling";
	else:
		$UserLabel.text = "Teacher";
		$VBoxContainer/FirstBtn.text = "MakeGame";
		$VBoxContainer/SecondBtn.text = "Orthography";

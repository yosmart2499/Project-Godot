extends Control

func _ready():
	if(UserAccess.user_type == UserAccess.Category.TEACHER):
		$UserLabel.text = "Teacher";
		$VBoxContainer/FirstBtn.text = "Add";
		$VBoxContainer/SecondBtn.text = "Change";
		$VBoxContainer/ThirdBtn.text = "Delete"

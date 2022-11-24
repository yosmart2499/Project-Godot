extends Control

func _ready() -> void:
	if(UserAccess.user_type == UserAccess.Category.STUDENT):
		$UserLabel.text = "Student";
		$BuyMonster.show();
	else:
		$UserLabel.text = "Teacher";

func _on_Questionnaire_pressed() -> void:
	if(UserAccess.user_type == UserAccess.Category.TEACHER):
		UserAccess.set_screen(UserAccess.Scene.ADD_QUESTIONNAIRE);
	if(UserAccess.user_type == UserAccess.Category.STUDENT):
		UserAccess.set_screen(UserAccess.Scene.GAME_QUESTIONNAIRE);


func _on_BuyMonster_pressed() -> void:
	if(UserAccess.user_type == UserAccess.Category.STUDENT):
		UserAccess.set_screen(UserAccess.Scene.MONSTER_MARKET);

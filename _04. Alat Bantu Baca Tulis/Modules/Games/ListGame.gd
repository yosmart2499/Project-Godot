extends Control

export var identify_databse_res: Resource = preload("res://Assets/Resources/identify_database.tres");

const save_path_identify: String = "user://identify_database.tres";

func _ready() -> void:
	self.identify_databse_res = SaveLoading.load_from_resource_general(self.identify_databse_res, self.save_path_identify);
	if(UserAccess.user_type == UserAccess.Category.STUDENT):
		$UserLabel.text = "Siswa";
		if(self.identify_databse_res.selected_grapheme.size() < 4):
			$VBoxContainer/Identify.disabled = true;
		$BuyMonster.show();
	else:
		$UserLabel.text = "Guru";

func _on_Questionnaire_pressed() -> void:
	if(UserAccess.user_type == UserAccess.Category.TEACHER):
		UserAccess.set_screen(UserAccess.Scene.ADD_QUESTIONNAIRE);
	if(UserAccess.user_type == UserAccess.Category.STUDENT):
		UserAccess.set_screen(UserAccess.Scene.GAME_QUESTIONNAIRE);

func _on_BuyMonster_pressed() -> void:
	if(UserAccess.user_type == UserAccess.Category.STUDENT):
		UserAccess.set_screen(UserAccess.Scene.MONSTER_MARKET);

func _on_Identify_pressed():
	if(UserAccess.user_type == UserAccess.Category.STUDENT):
		if(self.identify_databse_res.selected_grapheme.size() < 4):
			return;
		UserAccess.set_screen(UserAccess.Scene.IDENTIFY_GAME);
	if(UserAccess.user_type == UserAccess.Category.TEACHER):
		UserAccess.set_screen(UserAccess.Scene.IDENTIFY_SELECT);

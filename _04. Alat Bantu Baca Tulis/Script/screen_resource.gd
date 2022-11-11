extends Resource
class_name ScreenNavigator

export var user_selection_screen: PackedScene = preload("res://Modules/UI/User Selection/UserSelection.tscn");
export var choose_feature_screen: PackedScene = preload("res://Modules/UI/Choose Feature/ChooseFeature.tscn");

func produce_instance(user_type:int, screen_type: int):
	if(user_type == -1 && screen_type == -1):
		return self.user_selection_screen.instance();
	if(screen_type == UserAccess.Scene.CHOOSE_FEATURE):
		return self.choose_feature_screen.instance();

func step_back():
	if(UserAccess.screen_type == 0):
		UserAccess.set_user(-1);
		UserAccess.set_screen(-1);

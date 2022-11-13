extends Resource
class_name ScreenNavigator

export var user_selection_screen: PackedScene = preload("res://Modules/UI/User Selection/UserSelection.tscn");
export var choose_feature_screen: PackedScene = preload("res://Modules/UI/Choose Feature/ChooseFeature.tscn");
export var add_edit_delete_display_view_screen: PackedScene = preload("res://Modules/UI/Add Edit Delete Display View/Add Edit Delete.tscn");

func produce_instance(user_type:int, screen_type: int):
	if(user_type == -1 && screen_type == -1):
		return self.user_selection_screen.instance();
	if(screen_type == UserAccess.Scene.CHOOSE_FEATURE):
		return self.choose_feature_screen.instance();
	if(user_type == UserAccess.Category.TEACHER && screen_type == UserAccess.Scene.ADD_EDIT_DELETE):
		return self.add_edit_delete_display_view_screen.instance();

func step_back():
	if(UserAccess.screen_type == UserAccess.Scene.CHOOSE_FEATURE):
		UserAccess.set_user(-1);
		UserAccess.set_screen(-1);
	if(UserAccess.user_type == UserAccess.Category.TEACHER && UserAccess.screen_type == UserAccess.Scene.ADD_EDIT_DELETE):
		UserAccess.set_screen(0);

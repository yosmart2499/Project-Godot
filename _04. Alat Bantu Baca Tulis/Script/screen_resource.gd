extends Resource
class_name ScreenNavigator

export var user_selection_screen: PackedScene = preload("res://Modules/UI/User Selection/UserSelection.tscn");
export var choose_feature_screen: PackedScene = preload("res://Modules/UI/Choose Feature/ChooseFeature.tscn");
export var add_edit_delete_display_view_screen: PackedScene = preload("res://Modules/UI/Add Edit Delete Display View/Add Edit Delete.tscn");
export var grapheme_form_screen: PackedScene = preload("res://Modules/UI/Add Edit Delete Display View/Add Change/AddChange.tscn");
export var grapheme_list_screen: PackedScene = preload("res://Modules/UI/Add Edit Delete Display View/Delete Display/DisplayList.tscn");
export var grapheme_item_screen: PackedScene = preload("res://Modules/UI/Add Edit Delete Display View/View/View.tscn");

func produce_instance():
	if(UserAccess.user_type == -1 && UserAccess.screen_type == -1):
		return self.user_selection_screen.instance();
	if(UserAccess.screen_type == UserAccess.Scene.CHOOSE_FEATURE):
		return self.choose_feature_screen.instance();
	if(UserAccess.user_type == UserAccess.Category.TEACHER && UserAccess.screen_type == UserAccess.Scene.ADD_EDIT_DELETE):
		return self.add_edit_delete_display_view_screen.instance();
	if(UserAccess.screen_type == UserAccess.Scene.GRAPHEME_FORM):
		return self.grapheme_form_screen.instance();
	if(UserAccess.screen_type == UserAccess.Scene.DISPLAY_GRAPHEME_LIST):
		return self.grapheme_list_screen.instance();
	if(UserAccess.screen_type == UserAccess.Scene.DISPLAY_GRAPHEME_ITEM):
		return self.grapheme_item_screen.instance();

func step_back():
	if(UserAccess.screen_type == UserAccess.Scene.CHOOSE_FEATURE):
		UserAccess.set_user(-1);
		UserAccess.set_screen(-1);
	if(UserAccess.user_type == UserAccess.Category.TEACHER && UserAccess.screen_type == UserAccess.Scene.ADD_EDIT_DELETE):
		UserAccess.set_screen(UserAccess.Scene.CHOOSE_FEATURE);
	if(UserAccess.user_type == UserAccess.Category.TEACHER && UserAccess.screen_type == UserAccess.Scene.GRAPHEME_FORM):
		UserAccess.set_screen(UserAccess.Scene.ADD_EDIT_DELETE);
	if(UserAccess.user_type == UserAccess.Category.TEACHER && UserAccess.screen_type == UserAccess.Scene.DISPLAY_GRAPHEME_LIST):
		UserAccess.set_screen(UserAccess.Scene.ADD_EDIT_DELETE);
	if(UserAccess.user_type == UserAccess.Category.TEACHER && UserAccess.screen_type == UserAccess.Scene.DISPLAY_GRAPHEME_ITEM):
		UserAccess.set_screen(UserAccess.Scene.DISPLAY_GRAPHEME_LIST);
	if(UserAccess.user_type == UserAccess.Category.STUDENT && UserAccess.screen_type == UserAccess.Scene.DISPLAY_GRAPHEME_LIST):
		UserAccess.set_screen(UserAccess.Scene.CHOOSE_FEATURE);
	if(UserAccess.user_type == UserAccess.Category.STUDENT && UserAccess.screen_type == UserAccess.Scene.DISPLAY_GRAPHEME_ITEM):
		UserAccess.set_screen(UserAccess.Scene.DISPLAY_GRAPHEME_LIST);

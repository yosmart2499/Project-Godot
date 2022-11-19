extends Button

var item_obj: Object;

func set_attributes(grapheme: Object, mode: bool):
	self.text = grapheme.text;
	self.toggle_mode = mode;
	self.item_obj = grapheme;

func _on_Item_pressed():
	if(UserAccess.mode_type == UserAccess.Mode.CHANGE && UserAccess.user_type == UserAccess.Category.TEACHER):
		UserAccess.select_item(item_obj);
		UserAccess.set_screen(UserAccess.Scene.DISPLAY_GRAPHEME_ITEM);
	if(UserAccess.user_type == UserAccess.Category.STUDENT):
		UserAccess.select_item(item_obj);
		UserAccess.set_screen(UserAccess.Scene.DISPLAY_GRAPHEME_ITEM);

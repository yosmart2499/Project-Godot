extends Button

func set_attributes(grapheme: GraphemeItem, mode: bool):
	self.text = grapheme.text;
	self.toggle_mode = mode;
	UserAccess.select_item(grapheme);

func _on_Item_pressed():
	UserAccess.set_screen(UserAccess.Scene.DISPLAY_GRAPHEME_ITEM);

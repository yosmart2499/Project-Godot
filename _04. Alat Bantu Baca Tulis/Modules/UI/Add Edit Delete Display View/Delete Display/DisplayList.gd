extends Control

export var item_scene: PackedScene = preload("res://Modules/UI/Add Edit Delete Display View/Delete Display/Item.tscn");

var toggle_mode: bool = false;

func _ready() -> void:
	if(UserAccess.user_type == UserAccess.Category.TEACHER):
		$UserLabel.text = "Teacher";
		self.toggle_mode = true;
		$WindowSize/ItemList.clear();
		for key in UserAccess.ref_ortho_repo.show_list_item():
			$WindowSize/ItemList.add_item(key);
		if(UserAccess.mode_type == UserAccess.Mode.CHANGE):
			$DeleteBtn.hide();
		if(UserAccess.mode_type == UserAccess.Mode.DELETE):
			$DeleteBtn.show();
	else:
		$UserLabel.text = "Student";
		$DeleteBtn.hide();


func _on_ItemList_item_selected(index: int) -> void:
	for child in $WindowSize/ScrollContainer/GridContainer.get_children():
		child.queue_free();
	for grapheme in UserAccess.ref_ortho_repo.show_list_item($WindowSize/ItemList.get_item_text(index)):
		var item_instance: Button = item_scene.instance();
		item_instance.set_attributes(grapheme, toggle_mode);
		$WindowSize/ScrollContainer/GridContainer.add_child(item_instance);

func _on_DeleteBtn_pressed():
	$DeleteConfirmation.popup_centered_ratio(0.2);

func _on_DeleteConfirmation_confirmed():
	for child in $WindowSize/ScrollContainer/GridContainer.get_children():
		if(child.pressed):
			var type: String = $WindowSize/ItemList.get_item_text($WindowSize/ItemList.get_selected_items()[0]);
			UserAccess.ref_ortho_repo.delete_item(child.text, type);
	self._on_ItemList_item_selected(0);
	$DeleteConfirmation.hide();

func _on_DeleteConfirmation_popup_hide():
	for child in $WindowSize/ScrollContainer/GridContainer.get_children():
		if(child.pressed):
			child.pressed = false;

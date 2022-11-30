extends Control

export var item_container_scene: PackedScene = preload("res://Modules/Games/Identify an Image/Select Word/ItemContainer.tscn");
export var identify_databse_res: Resource = preload("res://Assets/Resources/identify_database.tres");

const save_path: String = "user://identify_database.tres";

func _ready() -> void:
	self.identify_databse_res = SaveLoading.load_from_resource_general(self.identify_databse_res, save_path);
	self.identify_databse_res.connect("selected_change", self, "change_display_chosen");
	self.change_display_chosen();
	$WindowSize/ItemList.clear();
	for key in UserAccess.ref_ortho_repo.show_list_item():
		$WindowSize/ItemList.add_item(key);

func change_display_chosen() -> void:
	$ChosenWord.text = "Chosen Word: 4/" + String(self.identify_databse_res.selected_grapheme.size());
	if(self.identify_databse_res.selected_grapheme.size() > 3):
		$ChosenWord.modulate = Color.white;
	else:
		$ChosenWord.modulate = Color.red;

func _on_ItemList_item_selected(index: int) -> void:
	for child in $WindowSize/ScrollContainer/GridContainer.get_children():
		child.queue_free();
	for grapheme in UserAccess.ref_ortho_repo.show_list_item($WindowSize/ItemList.get_item_text(index)):
		if(grapheme.text_image != null):
			var item_container: Node = self.item_container_scene.instance();
			item_container.set_grapheme_container(grapheme);
			$WindowSize/ScrollContainer/GridContainer.add_child(item_container);

func _on_SelectWord_tree_exited():
	SaveLoading.save_to_resource_general(self.identify_databse_res, self.save_path);

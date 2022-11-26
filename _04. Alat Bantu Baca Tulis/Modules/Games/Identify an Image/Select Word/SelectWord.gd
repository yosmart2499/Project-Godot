extends Control

func _ready() -> void:
	$WindowSize/ItemList.clear();
	for key in UserAccess.ref_ortho_repo.show_list_item():
		$WindowSize/ItemList.add_item(key);

func _on_ItemList_item_selected(index: int) -> void:
	for child in $WindowSize/ScrollContainer/GridContainer.get_children():
		child.queue_free();
	for grapheme in UserAccess.ref_ortho_repo.show_list_item($WindowSize/ItemList.get_item_text(index)):
		var new_node = $ItemContainer.duplicate(DUPLICATE_USE_INSTANCING);
		new_node.show();
		$WindowSize/ScrollContainer/GridContainer.add_child(new_node);

extends HBoxContainer

export var identify_databse_res: Resource = preload("res://Assets/Resources/identify_database.tres");

const save_path: String = "user://identify_database.tres";

var grapheme_item: Object;

func set_grapheme_container(grapheme: Object) -> void:
	self.identify_databse_res = SaveLoading.load_from_resource_general(self.identify_databse_res, self.save_path);
	$Word.text = grapheme.text;
	self.grapheme_item = grapheme;
	if(self.identify_databse_res.find_selected_item(grapheme_item)):
		$Select.pressed = true;

func _on_Word_pressed() -> void:
	$Select.pressed = not $Select.pressed;

func _on_Select_toggled(button_pressed: bool) -> void:
	if(button_pressed):
		$Select.text = "Yes";
		self.identify_databse_res.add_selected_item(self.grapheme_item);
	else:
		$Select.text = "No";
		self.identify_databse_res.remove_selected_item(self.grapheme_item);

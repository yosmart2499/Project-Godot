extends Node

var temp_repo;
var file_path: String = "user://data.save";

func _ready():
	if(SaveLoading.load_from_file(file_path) == null):
		temp_repo = OrthographyRepository.new();
	for i in range(10):
		var item: GraphemeItem = GraphemeItem.new(String(i), String(i % 2));
		temp_repo.repo_add_item(item);
		temp_repo.repo_add_item_array(item);
		SaveLoading.save_to_file(temp_repo, file_path);
	
	print(temp_repo.repository_dict);
	
	for mod_to_zero in temp_repo.show_list_item("0"):
		print(mod_to_zero.text);
	
	print(temp_repo.show_item("6"));


func _on_SaveButton_pressed():
	SaveLoading.save_to_file(temp_repo, file_path);


func _on_LoadButton_pressed():
	var temp = SaveLoading.load_from_file(file_path);
	print(temp);

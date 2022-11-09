extends Node

export var main_repo_res: Resource;

var save_res_path: String = "user://repository_resource.tres"

func _ready():
	produce_item_repo();

func produce_item_repo():
	for i in range(10):
		main_repo_res.add_item(ItemResource.new(String(i), String(i % 2)));


func _on_SaveButton_pressed():
	ResourceSaver.save(save_res_path, main_repo_res);


func _on_LoadButton_pressed():
	var temp_saved_res = load(save_res_path);
	print(temp_saved_res.repository_dict);
	for keys in temp_saved_res.repository_dict.keys():
		print(keys);
		for object in temp_saved_res.repository_dict[keys]:
			print(object.type + " - " + object.text);

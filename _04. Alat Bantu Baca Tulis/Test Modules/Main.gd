extends Node

export var repo_resource: Resource;

var file_path: String = "user://data.save";
var resource_path: String = "user://repository_resource.tres";

onready var ref_repo: Resource = (repo_resource as OrthographyRepository);

func _ready() -> void:
	produce_list_item();
	print(self.ref_repo.find_item("8").text);
	self.ref_repo.find_item("8").text = String(0) + String(8);
	print(self.ref_repo.find_item("08").text);
	self.ref_repo.delete_item("08", true);
	self.ref_repo.change_item("4", "04", self.ref_repo.TEXT);
	self.ref_repo.change_item("04", "01", self.ref_repo.TYPE);

func produce_list_item() -> void:
	print(self.ref_repo);
	for i in range(10):
		self.ref_repo.add_item(GraphemeItem.new(String(i), String(i%2)));


func _on_SaveButton_pressed() -> void:
	SaveLoading.save_to_resource(self.repo_resource, self.resource_path);

func _on_LoadButton_pressed() -> void:
	self.repo_resource = SaveLoading.load_from_resource(self.resource_path);
	print(self.ref_repo.repository_dict);
	for keys in self.ref_repo.repository_dict.keys():
		for object in self.ref_repo.repository_dict.get(keys):
			print(object.text + " - "  + object.type);

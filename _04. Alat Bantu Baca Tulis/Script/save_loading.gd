extends Node

"""
Always use export in the var to save something.
"""
export var orthography_repo: Resource = preload("res://Assets/Resources/orthography_repository.tres");

var save_path: String = "user://orthography_repository.tres";


func save_to_resource() -> void:
	print(ResourceSaver.save(self.save_path, self.orthography_repo));

func load_from_resource() -> void:
	var temp_directory: Directory = Directory.new();
	if(temp_directory.file_exists(self.save_path)):
		self.orthography_repo = load(self.save_path);
		self.orthography_repo.show_repository();

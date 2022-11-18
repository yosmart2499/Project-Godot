extends Node

"""
Always use export in the var to save something.
"""
var orthography_repo: OrthographyRepository = OrthographyRepository.new();

var save_path: String = "user://orthography_repository.save";

func _ready():
	load_from_resource();

func save_to_resource() -> void:
	var temp_file = File.new()
	temp_file.open(save_path, File.WRITE)
	temp_file.store_var(orthography_repo, true)
	temp_file.close()

func load_from_resource() -> void:
	var temp_file = File.new()
	if temp_file.file_exists(save_path):
		temp_file.open(save_path, File.READ)
		orthography_repo.repository_dict = temp_file.get_var(true).repository_dict;
		temp_file.close();
	UserAccess.load_repo();

"""
Saving using store_var and get_var must be aware of the type of the things that being saved.
And for loading, because the load only refrenced use only the property of the saved file not the whole object like above.
In this case every costum object that I save in the repository convert itself to object.
And every code that use GraphemeItem will not work. Only Object typing that can do that.
Godot type casting is confusing when using on save, because it save the variant value.
So either use C++ or deal with the type casting problem or don't use at all.
"""

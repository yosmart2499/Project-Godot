extends Node

func save_to_file(data, path: String) -> void:
	var file: = File.new();
	file.open(path, File.WRITE);
	file.store_var(data, true);
	file.close();

func load_from_file(path: String):
	var file: = File.new();
	var data;
	if(file.file_exists(path)):
		file.open(path, File.READ);
		data = file.get_var(true);
		file.close();
	return data;

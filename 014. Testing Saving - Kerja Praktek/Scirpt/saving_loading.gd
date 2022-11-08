extends Node

func save_to_file(file_path: String, file_data) -> void:
	var file = File.new()
	file.open(file_path, File.WRITE)
	file.store_var(file_data, true)
	file.close()


func load_from_file(file_path: String):
	var file = File.new()
	var data;
	if file.file_exists(file_path):
		file.open(file_path, File.READ)
		data = file.get_var(true)
		file.close()
	return data;

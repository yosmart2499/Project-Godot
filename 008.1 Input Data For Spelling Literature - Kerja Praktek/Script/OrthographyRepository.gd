extends Node
class_name OrthographyRepository

enum PHRASETYPE {VOWEL, CONSONANT, COMBINED_VOWEL, COMBINED_CONSONANT, SPELLING, WORD}

const save_path = "user://"

var orthography_json_path: String = save_path + "JSON/orthography_repository.json";
var orthography_dictionary: Dictionary = {};

func add_orthography_dictionary(type_index: int, phrase: String, sound_path: String = "", image_path: String = "") -> void:
	var type = PHRASETYPE.keys()[type_index];
	phrase = phrase.to_upper();
	if(!orthography_dictionary.has(type)):
		orthography_dictionary[type] = {};
	orthography_dictionary[type].merge({phrase: {"text_lower" : phrase.to_lower(), "text_upper" : phrase, "sound_path" : sound_path, "image_path" : image_path}}, true);


# Code below is the cleaner among them.
func change_orthography_dictionary(type_index: int, phrase: String, property: String, value: String) -> void:
	phrase = phrase.to_upper();
	var type = PHRASETYPE.keys()[type_index];
	var temporary_dictionary = orthography_dictionary.get(type);
	if(temporary_dictionary == null):
		push_error("Dictionary is null. There is no: " + type + " | change_orthography_dictionary()")
		return;
	temporary_dictionary = temporary_dictionary.get(phrase)
	if(temporary_dictionary == null):
		push_error("Dictionary is null. There is no: " + phrase + " | change_orthography_dictionary()")
		return;
	temporary_dictionary = temporary_dictionary.get(property);
	if(temporary_dictionary == null):
		push_error("Dictionary is null. There is no: " + property + " | change_orthography_dictionary()")
		return;
	else:
		orthography_dictionary.get(type).get(phrase)[property] = value;


func access_orthography_dictionary(type_index: int = -1, phrase: String = "", property: String = ""):
	if(type_index == -1):
		return orthography_dictionary.keys();
	
	var type = PHRASETYPE.keys()[type_index]
	var temporary_dictionary = orthography_dictionary.get(type);
	phrase = phrase.to_upper();
	
	if(temporary_dictionary == null):
		push_error("Dictionary is null. There is no: " + type + " | access_orthography_dictionary()")
		return {};
	elif(phrase == "" && property == ""):
		return temporary_dictionary;
	temporary_dictionary = temporary_dictionary.get(phrase);
	if(temporary_dictionary == null):
		push_error("Dictionary is null. There is no: " + phrase + " | access_orthography_dictionary()");
		return {};
	elif(property == ""):
		return temporary_dictionary;
	temporary_dictionary = temporary_dictionary.get(property);
	if(temporary_dictionary == null):
		push_error("Dictionary is null. There is no: " + property + " | access_orthography_dictionary()");
		return {};
	else:
		return temporary_dictionary;


func delete_orthography_dictionary(type_index: int = -1, phrase: String = "", property: String = "") -> void:
	if(type_index == -1):
		orthography_dictionary = {};
		return;
	phrase = phrase.to_upper();
	var type = PHRASETYPE.keys()[type_index];
	# The get function if the dictionary that it searched empty return null. So .empty() function can be called.
	var temporary_dictionary = orthography_dictionary.get(type);
	
	#Dont use temporary_dictionary.empty() because if the name is different or typo it will return error.
	if(temporary_dictionary == null):
		push_error("Dictionary is null. There is no: " + type + " | delete_orthography_dictionary()")
		return;
	elif(phrase == "" && property == ""):
		orthography_dictionary[type] = {};
		return;
	temporary_dictionary = temporary_dictionary.get(phrase);
	if(temporary_dictionary == null):
		push_error("Dictionary is null. There is no: " + phrase + " | delete_orthography_dictionary()")
		return;
	elif(property == ""):
		orthography_dictionary.get(type).erase(phrase);
		return;
	temporary_dictionary = temporary_dictionary.get(property);
	if(temporary_dictionary == null):
		push_error("Dictionary is null. There is no: " + property + " | delete_orthography_dictionary()")
		return;
	else:
		orthography_dictionary.get(type).get(phrase)[property] = "";
		return;


func save_dictionary_json() -> void:
	var save_directory: Directory = Directory.new();
	save_directory.open(save_path);
	save_directory.make_dir("JSON");
	
	var save_file: File = File.new();
	save_file.open(orthography_json_path, File.WRITE);
	"""
	Don't know what happened here.
	Fixed: The JSON file is not there. It must be Godot that delete after shutting down computer or Windows.
	"""
	save_file.store_line(to_json(orthography_dictionary));
	save_file.close();


func read_json_dictionary() -> void:
	var data_file = File.new();
	
	if(not data_file.file_exists(orthography_json_path)):
		return;
	
	data_file.open(orthography_json_path, File.READ);
	var data_file_dictionary : Dictionary = parse_json(data_file.get_as_text());
	data_file.close();
	orthography_dictionary = data_file_dictionary;

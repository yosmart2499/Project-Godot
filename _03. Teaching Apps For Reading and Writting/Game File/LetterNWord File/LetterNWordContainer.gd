extends Node

export (String) var letter_property_json_path;

var letter_property_dictionary;

func _ready():
	letter_property_dictionary = parse_json_to_dictionary();
	print(letter_property_dictionary.a.text);

func parse_json_to_dictionary():
	var file = File.new();
	file.open(letter_property_json_path, File.READ);
	var context_as_text = file.get_as_text();
	var context_as_dictionary = parse_json(context_as_text);
	return context_as_dictionary;

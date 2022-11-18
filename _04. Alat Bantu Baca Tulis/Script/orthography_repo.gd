extends Object
class_name OrthographyRepository

enum {TEXT, TYPE, SPELLING, PRONOUNCE}

export var repository_dict: Dictionary;

func add_item(item: GraphemeItem) -> void:
	if(self.find_item(item.text, item.type) != null):
		return;
	if(not self.repository_dict.get(item.type)):
		self.repository_dict[item.type] = [];
	self.repository_dict[item.type].append(item);

func find_item(text: String, type: String) -> GraphemeItem:
	if(type in self.repository_dict.keys()):
		for item in self.repository_dict[type]:
			if(item.text == text.to_lower()):
				return item;
	return null;

func delete_item(text: String, type: String) -> void:
	var temp_item: GraphemeItem = self.find_item(text, type);
	if(temp_item != null):
		self.repository_dict[type].erase(temp_item);
		temp_item.free();
	if(self.repository_dict[type].empty()):
		print(self.repository_dict.erase(type));

func change_item(text: String, type: String, data, flags:int) -> void:
	var ref_item: GraphemeItem = self.find_item(text, type);
	ref_item.text = ref_item.text.to_lower();
	ref_item.type = ref_item.type.to_lower();
	if(flags != TYPE):
		if(flags == TEXT):
			ref_item.text = data;
			return;
		if(flags == SPELLING):
			ref_item.spelling = data;
			return;
		if(flags == PRONOUNCE):
			ref_item.pronounce = data;
			return;
	self.delete_item(text, type);
	ref_item.type = data;
	self.add_item(ref_item);

func show_repository() -> void:
	var counter: = 0;
	print(self.repository_dict);
	for key in self.repository_dict.keys():
		for item in self.repository_dict[key]:
			if(item.pronounce == null || item.text_image == null):
				print(String(counter) + " - " + key + " - " + item.text + " - " + String(item.spelling));
			else:
				print(String(counter) + " - " + key + " - " + item.text + " - " + String(item.spelling) + " - " + String(item.pronounce) + " - " + String(item.text_image));
			counter += 1;

func show_list_item(type: String = "") -> Array:
	if(type == ""):
		return self.repository_dict.keys();
	return self.repository_dict.get(type, []);



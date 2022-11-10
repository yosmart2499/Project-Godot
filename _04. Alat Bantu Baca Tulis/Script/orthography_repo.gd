extends Resource
class_name OrthographyRepository

enum {TEXT, TYPE, SPELLING, PRONOUNCE}

export var repository_dict: Dictionary;

func add_item(item: GraphemeItem) -> void:
	var ref_item: GraphemeItem = self.find_item(item.text);
	if(ref_item != null):
		return;
	if(not self.repository_dict.has(item.type)):
		self.repository_dict[item.type] = [];
	self.repository_dict[item.type].append(item);

func delete_item(text: String, default: bool = false) -> GraphemeItem:
	var ref_item: GraphemeItem = self.find_item(text);
	repository_dict.get(ref_item.type).erase(ref_item);
	if(default):
		ref_item.free();
		return null;
	return ref_item;

func change_item(text: String, data, flags:int) -> void:
	var ref_item: GraphemeItem = self.find_item(text);
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
	self.delete_item(text);
	ref_item.type = data;
	self.add_item(ref_item);

func find_item(text: String) -> GraphemeItem:
	for key in self.repository_dict.keys():
		for item in self.repository_dict.get(key):
			if(item.text == text):
				return item;
	return null;

func show_list_item(type: String) -> Array:
	return self.repository_dict.get(type, []);



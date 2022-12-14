extends Object
class_name OrthographyRepository

enum {TEXT, TYPE, SPELLING, PRONOUNCE}

export var repository_dict: Dictionary;

func add_item(item: GraphemeItem) -> void:
	if(self.find_item(item.text, item.type) != null):
		self.delete_item(item.text, item.type);
	if(not self.repository_dict.get(item.type)):
		self.repository_dict[item.type] = [];
	self.repository_dict[item.type].append(item);

func change_item(item: GraphemeItem, prev_item: Object) -> void:
	if(self.find_item(prev_item.text, prev_item.type) != null):
		self.delete_item(prev_item.text, prev_item.type);
	self.add_item(item);

func find_item(text: String, type: String) -> GraphemeItem:
	if(type in self.repository_dict.keys()):
		for item in self.repository_dict[type]:
			if(item.text == text.to_lower()):
				return item;
	return null;

func delete_item(text: String, type: String) -> void:
	var temp_item: Object = self.find_item(text, type);
	if(temp_item != null):
		self.repository_dict[type].erase(temp_item);
		temp_item.free();
#	if(self.repository_dict[type].empty()):
#		print(self.repository_dict.erase(type));

func show_repository() -> void:
	var counter: = 0;
	print(self.repository_dict);
	for key in self.repository_dict.keys():
		for item in self.repository_dict[key]:
			counter += 1;
			print(String(counter) + " - " + key + " - " + item.text + " - " + String(item.spelling));

func show_list_item(type: String = "") -> Array:
	if(type == ""):
		return self.repository_dict.keys();
	return self.repository_dict.get(type, []);



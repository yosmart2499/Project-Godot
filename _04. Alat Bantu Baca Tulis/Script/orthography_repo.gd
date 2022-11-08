extends Object
class_name OrthographyRepository

export var repository_dict: Dictionary;
export var repository_array: Array;

func repo_add_item(item: GraphemeItem) -> void:
	if(not self.repository_dict.has(item.type)):
		self.repository_dict[item.type] = [];
	self.repository_dict[item.type].append(item);

func repo_add_item_array(item: GraphemeItem) -> void:
	self.repository_array.append(item);

func show_list_item(type: String) -> Array:
	return self.repository_dict.get(type, []);

func show_item(text: String):
	for key in self.repository_dict.keys():
		for item in self.repository_dict.get(key):
			if(item.text == text):
				return item;
	return null;

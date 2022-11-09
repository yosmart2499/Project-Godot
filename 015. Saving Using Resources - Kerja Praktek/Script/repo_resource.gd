extends Resource
class_name RepositoryResource

export var repository_dict: Dictionary;

func add_item(item: ItemResource):
	if(repository_dict.get(item.type) == null):
		repository_dict[item.type] = [];
	repository_dict.get(item.type).append(item);

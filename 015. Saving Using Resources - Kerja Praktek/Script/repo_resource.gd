extends Resource
class_name RepositoryResource

export var repository_dict: Dictionary;
export var test_img_save: StreamTexture;

func add_item(item: ItemResource):
	if(repository_dict.get(item.type) == null):
		repository_dict[item.type] = [];
	repository_dict.get(item.type).append(item);

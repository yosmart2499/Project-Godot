extends Node

export var main_repo_res: Resource = preload("res://Assets/Resource/repo.tres");

var save_res_path: String = "user://repository_resource.tres"
var img_path: String = "res://icon.png";

func _ready():
	produce_item_repo();

func produce_item_repo():
	var temp_img: Image = Image.new();
	var temp_texture: ImageTexture = ImageTexture.new();
	print(temp_img.load(img_path));
	temp_texture.create_from_image(temp_img);
	$TextureRect.texture = temp_texture;
	for i in range(10):
		var temp_item: ItemResource = ItemResource.new(String(i), String(i % 2));
		temp_item.img = $TextureRect.texture;
		main_repo_res.add_item(temp_item);


func _on_SaveButton_pressed():
	ResourceSaver.save(save_res_path, main_repo_res);


func _on_LoadButton_pressed():
	var temp_saved_res = load(save_res_path);
	main_repo_res = temp_saved_res;
	print(main_repo_res.repository_dict);
	for keys in temp_saved_res.repository_dict.keys():
		print(keys);
		for object in temp_saved_res.repository_dict[keys]:
			print(object.type + " - " + object.text);

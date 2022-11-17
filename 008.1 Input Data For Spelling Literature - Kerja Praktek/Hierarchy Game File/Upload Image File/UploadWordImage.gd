extends HBoxContainer

var screen_size: Vector2;
var default_texture: StreamTexture;

signal uploaded_file(image);

func start_drawing():
	yield(VisualServer,"frame_post_draw");
	screen_size = get_viewport().size;
	if($ImageContainer/ImageTexture.texture is StreamTexture):
		default_texture = $ImageContainer/ImageTexture.texture;

func reset_uploaded_image():
	$ImageContainer/ImageTexture.texture = default_texture;

func phrase_image_texture(texture: ImageTexture):
	$ImageContainer/ImageTexture.texture = texture;


func _on_UploadButton_pressed():
	$ImageUploadFileDialog.popup_centered(screen_size/2);


func _on_ImageUploadFileDialog_file_selected(path):
	var image: Image = Image.new();
	image.load(path);
	var texture: ImageTexture = ImageTexture.new()
	texture.create_from_image(image);
	$ImageContainer/ImageTexture.texture = texture;
	emit_signal("uploaded_file", image);

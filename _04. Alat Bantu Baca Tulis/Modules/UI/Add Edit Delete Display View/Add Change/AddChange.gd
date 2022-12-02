extends Control

onready var screen_size: Vector2 = get_viewport().size;
onready var default_img: StreamTexture = preload("res://icon.png");
onready var recording_effect: AudioEffectRecord = AudioServer.get_bus_effect(AudioServer.get_bus_index("Record"), 0);

func _ready() -> void:
	$UserLabel.text = "Guru"
	if(UserAccess.mode_type == UserAccess.Mode.ADD):
		$AddOrChange.text = "Tambah";
	else:
		$HBoxContainer/VBoxContainer2/Word.text = UserAccess.ref_selected_item.text;
		$HBoxContainer/VBoxContainer2/Type.text = UserAccess.ref_selected_item.type;
		$HBoxContainer/VBoxContainer2/Spelling.text = PoolStringArray(UserAccess.ref_selected_item.spelling).join("-");
		if(UserAccess.ref_selected_item.text_image != null):
			$HBoxContainer/VBoxContainer/Image.texture = UserAccess.ref_selected_item.text_image;
		if(UserAccess.ref_selected_item.pronounce != null):
			$HBoxContainer/VBoxContainer/HBoxContainer/StreamPlay.stream = UserAccess.ref_selected_item.pronounce;
		$AddOrChange.text = "Ganti";
		$HBoxContainer/VBoxContainer3/WordDisplay.text = $HBoxContainer/VBoxContainer2/Word.text.capitalize();
		$HBoxContainer/VBoxContainer3/SpellingDisplay.text = $HBoxContainer/VBoxContainer2/Spelling.text.capitalize().replace(" ", "");
		$HBoxContainer/VBoxContainer3/TypeDisplay.text = $HBoxContainer/VBoxContainer2/Type.text.capitalize();

func _on_UploadBtn_pressed() -> void:
	$HBoxContainer/VBoxContainer/ImgUpload.add_filter("*.png");
	$HBoxContainer/VBoxContainer/ImgUpload.add_filter("*.jpg");
	$HBoxContainer/VBoxContainer/ImgUpload.add_filter("*.jpeg");
	$HBoxContainer/VBoxContainer/ImgUpload.add_filter("*.gif");
	$HBoxContainer/VBoxContainer/ImgUpload.popup_centered(self.screen_size / 2);

func _on_ImgUpload_file_selected(path: String) -> void:
	var temp_img: Image = Image.new();
	var temp_texture: ImageTexture = ImageTexture.new();
	print(temp_img.load(path));
	temp_texture.create_from_image(temp_img);
	$HBoxContainer/VBoxContainer/Image.texture = temp_texture;

func _on_RecordBtn_pressed() -> void:
	if(self.recording_effect.is_recording_active()):
		$HBoxContainer/VBoxContainer/HBoxContainer/StreamPlay.stream = self.recording_effect.get_recording();
		self.recording_effect.set_recording_active(false);
		$HBoxContainer/VBoxContainer/HBoxContainer/RecordBtn.text = "Rekam";
		$HBoxContainer/VBoxContainer/HBoxContainer/PlayBtn.disabled = false;
		$HBoxContainer/VBoxContainer/HBoxContainer/StreamPlay.stop();
	else:
		self.recording_effect.set_recording_active(true);
		$HBoxContainer/VBoxContainer/HBoxContainer/RecordBtn.text = "Berhenti";
		$HBoxContainer/VBoxContainer/HBoxContainer/PlayBtn.disabled = true;

func _on_PlayBtn_pressed() -> void:
	$HBoxContainer/VBoxContainer/HBoxContainer/StreamPlay.volume_db = 20;
	$HBoxContainer/VBoxContainer/HBoxContainer/StreamPlay.play();

func _on_ConfrimBtn_pressed() -> void:
	var word_text: String = $HBoxContainer/VBoxContainer2/Word.text.to_lower();
	var type_text: String = $HBoxContainer/VBoxContainer2/Type.text.to_lower();
	var spelling_text: String = $HBoxContainer/VBoxContainer2/Spelling.text.to_lower();
	if(word_text.empty() || type_text.empty() || spelling_text.empty()):
		if(word_text.empty()):
			$WarningEmpty.window_title = "Kata Kosong!";
		elif(spelling_text.empty()):
			$WarningEmpty.window_title = "Ejaan Kosong!";
		elif(type_text.empty()):
			$WarningEmpty.window_title = "Tipe Kosong!";
		$WarningEmpty.dialog_text = "Tolong diisi format-nya."
		$WarningEmpty.popup_centered_ratio(0.3);
		return;
	var temp_item: GraphemeItem = GraphemeItem.new(word_text, type_text, spelling_text.split("-"));
	if($HBoxContainer/VBoxContainer/Image.texture != default_img):
		temp_item.text_image = $HBoxContainer/VBoxContainer/Image.texture;
	if($HBoxContainer/VBoxContainer/HBoxContainer/StreamPlay.stream != null):
		temp_item.pronounce = $HBoxContainer/VBoxContainer/HBoxContainer/StreamPlay.stream;
	if(UserAccess.mode_type == UserAccess.Mode.ADD):
		UserAccess.ref_ortho_repo.add_item(temp_item);
	else:
		UserAccess.ref_ortho_repo.change_item(temp_item, UserAccess.ref_selected_item);
		UserAccess.set_screen(UserAccess.Scene.DISPLAY_GRAPHEME_LIST);
		return;
	$HBoxContainer/VBoxContainer3/WordDisplay.text = $HBoxContainer/VBoxContainer2/Word.text.capitalize();
	$HBoxContainer/VBoxContainer3/SpellingDisplay.text = $HBoxContainer/VBoxContainer2/Spelling.text.capitalize().replace(" ", "");
	$HBoxContainer/VBoxContainer3/TypeDisplay.text = $HBoxContainer/VBoxContainer2/Type.text.capitalize();
	$HBoxContainer/VBoxContainer2/Word.text = "";
	$HBoxContainer/VBoxContainer2/Type.text = "";
	$HBoxContainer/VBoxContainer2/Spelling.text = "";
	$HBoxContainer/VBoxContainer/Image.texture = default_img;
	$HBoxContainer/VBoxContainer/HBoxContainer/StreamPlay.stream = null;

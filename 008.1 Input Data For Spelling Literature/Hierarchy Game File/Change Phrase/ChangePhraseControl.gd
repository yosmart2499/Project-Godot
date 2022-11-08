extends Control

signal font_done_adjusting;
signal deleted_text_keys(type_index, text_upper);

var property_dictionary: Dictionary;

func start_the_resize():
	resize_long_word_font();
	yield(self, "font_done_adjusting");
	toggle_loading_visibility();
	$HBoxContainer/VBoxContainer/SpellingSoundHBoxContainer.start_listening();
	$HBoxContainer/VBoxContainer/WordImageHBoxContainer.start_drawing();
	
	
func load_dictionary_property(accessed_property: Dictionary):
	if(accessed_property.empty()):
		start_the_resize();
		return;
	property_dictionary = accessed_property;
	var phrase_property = accessed_property.property_data;
	var phrase_type = accessed_property.phrase_type;
	
	$HBoxContainer/PhraseLabel.text = phrase_property.text_upper;
	var splitted_keys = phrase_type.split("_");
	if(splitted_keys.size() == 2):
		splitted_keys[0] = "C";
	splitted_keys = ".".join(splitted_keys);
	$HBoxContainer/VBoxContainer/PhraseType.text = splitted_keys.capitalize();
	
	if(!phrase_property.image_path == ""):
		var image: Image = Image.new();
		image.load(phrase_property.image_path);
		var texture = ImageTexture.new();
		texture.create_from_image(image);
		$HBoxContainer/VBoxContainer/WordImageHBoxContainer.phrase_image_texture(texture);
	
	if(!phrase_property.sound_path == ""):
		var sound_data = File.new();
		sound_data.open(phrase_property.sound_path, File.READ);
		var buffer = sound_data.get_buffer(sound_data.get_len());
		var stream_sample: AudioStreamSample = AudioStreamSample.new();
		for i in 200:
			buffer.remove(buffer.size()-1);
			buffer.remove(0);
		stream_sample.data = buffer;
		stream_sample.format = 1;
		stream_sample.mix_rate = 44100;
		stream_sample.stereo = true;
		sound_data.close();
		"""
		Run into the same problem. I don't know now what caused it. But the error it's not consistent.
		"""
		$HBoxContainer/VBoxContainer/SpellingSoundHBoxContainer.phrase_spelling_sample(stream_sample);
	
	start_the_resize();

func toggle_loading_visibility():
	$LoadingScreen.visible = !$LoadingScreen.visible;

func resize_long_word_font():
	var font_theme: Font = $HBoxContainer/PhraseLabel.get_font("font");
	
	while($HBoxContainer/PhraseLabel.rect_size.x > 655):
		font_theme.size -= 16;
		font_theme.size = clamp(font_theme.size, 16, font_theme.size);
		if(font_theme.size == 16):
			$HBoxContainer/PhraseLabel.clip_text = true;
		yield(VisualServer, "frame_post_draw");
	emit_signal("font_done_adjusting");


func _on_SpellingSoundHBoxContainer_recorded_spelling(recording: AudioStreamSample):
	recording.save_to_wav(property_dictionary.get("property_data").get("sound_path"));


func _on_WordImageHBoxContainer_uploaded_file(image: Image):
	image.save_png(property_dictionary.get("property_data").get("image_path"));


func _on_DeleteButton_pressed():
	emit_signal("deleted_text_keys", property_dictionary.get("type_index"), property_dictionary.get("property_data").get("text_upper"));

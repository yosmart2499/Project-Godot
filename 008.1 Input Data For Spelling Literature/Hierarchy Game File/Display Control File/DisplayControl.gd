extends Control

export (PackedScene) var phrase_button_scene;

signal ask_phrase_data(phrase_keys);
signal ask_change_data(phrase_keys, phrase_text);

var phrase_keys_original: String;


func set_phrase_option(phrase_keys: Array):
	for key in phrase_keys:
		$CenterContainer/HBoxContainer/OptionButton.add_item(two_word_type(key, true));

func two_word_type(key, original):
	if(original):
		var splitted_key = key.split("_");
		if(splitted_key.size() != 2):
			return key.capitalize();
		splitted_key[0] = "C";
		splitted_key = ".".join(splitted_key);
		return splitted_key.capitalize().replace(" ", "");
	else:
		var splitted_key = key.split(".")
		if(splitted_key.size() != 2):
			return key.to_upper();
		splitted_key[0] = "Combined";
		splitted_key = "_".join(splitted_key);
		return splitted_key.to_upper().replace(" ", "");


func instance_phrase_button(phrase_text: Array):
	for text_instance in phrase_text:
		var phrase_button: Button = phrase_button_scene.instance();
		phrase_button.text = text_instance.capitalize();
		$CenterContainer/GridContainer.add_child(phrase_button);
		phrase_button.connect("send_text_button", self, "change_phrase_pressed");

func change_phrase_pressed(button_text):
	self.hide();
	emit_signal("ask_change_data", phrase_keys_original, button_text.to_upper());
	

func _on_DisplayButton_pressed():
	$CenterContainer/HBoxContainer/OptionButton.hide();
	$CenterContainer/HBoxContainer/DisplayButton.hide();
	var index_type = $CenterContainer/HBoxContainer/OptionButton.selected;
	var index_text = $CenterContainer/HBoxContainer/OptionButton.get_item_text(index_type);
	phrase_keys_original = two_word_type(index_text, false);
	emit_signal("ask_phrase_data", phrase_keys_original);


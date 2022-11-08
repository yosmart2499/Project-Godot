extends Node

export (PackedScene) var input_control_scene;
export (PackedScene) var change_control_scene;

var input_control: Control;
var change_control: Control;
var input_or_change: bool = false;
var accessed_phrase: Dictionary;


func _enter_tree():
	$OrthographyRepository.read_json_dictionary();


func _ready():
	$OrthographyRepository.add_orthography_dictionary($OrthographyRepository.PHRASETYPE.VOWEL, "a");
	$DisplayControl.set_phrase_option($OrthographyRepository.access_orthography_dictionary());

func _notification(what):
	if(what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		$OrthographyRepository.save_dictionary_json();


func _unhandled_key_input(_event):
	if(Input.is_action_just_pressed("space_input") && not input_or_change):
		if(is_instance_valid(input_control)):
			return;
		$DisplayControl.hide();
		input_control = input_control_scene.instance();
		input_control.start_input_control();
		input_control.connect("phrase_value_property_submitted", self, "submit_phrase_dictionary");
		self.add_child(input_control);
		if(is_instance_valid(change_control)):
			accessed_phrase.clear();
			change_control.disconnect("deleted_text_keys", self, "delete_phrase_dictionary");
			self.remove_child(change_control);
			change_control.queue_free();

	if(Input.is_action_just_pressed("space_input") && input_or_change):
		if(is_instance_valid(change_control)):
			return;
		change_control = change_control_scene.instance();
		change_control.load_dictionary_property(accessed_phrase);
		change_control.connect("deleted_text_keys", self, "delete_phrase_dictionary");
		self.add_child(change_control);
		if(is_instance_valid(input_control)):
			input_control.disconnect("phrase_value_property_submitted", self, "submit_phrase_dictionary");
			self.remove_child(input_control);
			input_control.queue_free();


func delete_phrase_dictionary(type_index, text_upper):
	$OrthographyRepository.delete_orthography_dictionary(type_index, text_upper);
	$OrthographyRepository.save_dictionary_json();
	get_tree().reload_current_scene();


func submit_phrase_dictionary(phrase_type_index, phrase_text, sound_path, image_path):
	$OrthographyRepository.add_orthography_dictionary(phrase_type_index, phrase_text, sound_path, image_path);
	accessed_phrase["property_data"] = $OrthographyRepository.access_orthography_dictionary(phrase_type_index, phrase_text);
	accessed_phrase["phrase_type"] = $OrthographyRepository.PHRASETYPE.keys()[phrase_type_index];
	accessed_phrase["type_index"] = phrase_type_index;


func _on_CooldownTimer_timeout():
	input_or_change = !input_or_change;


func _on_DisplayControl_ask_phrase_data(phrase_keys):
	var text_phrase_data: Array = $OrthographyRepository.orthography_dictionary.get(phrase_keys).keys();
	$DisplayControl.instance_phrase_button(text_phrase_data);


func _on_DisplayControl_ask_change_data(phrase_keys, phrase_text):
	change_control = change_control_scene.instance();
	accessed_phrase["property_data"] = $OrthographyRepository.orthography_dictionary.get(phrase_keys).get(phrase_text);
	accessed_phrase["phrase_type"] = phrase_keys;
	accessed_phrase["type_index"] = $OrthographyRepository.PHRASETYPE[phrase_keys];
	change_control.load_dictionary_property(accessed_phrase);
	self.add_child(change_control);
	change_control.connect("deleted_text_keys", self, "delete_phrase_dictionary");

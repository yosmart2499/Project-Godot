extends Control

signal phrase_value_property_submitted(phrase_type_index, phrase_text, sound_path, image_path);

const phrase_value_property_dictionary_default: Dictionary = {
	"phrase_type_index" : 0,
	"phrase_text" : "",
	"sound_path_n_sample" : ["", null],
	"image_path_n_the_image" : ["", null],
}

"""
Learn more about reference btw so that cases likephrase_value_property_dictionary = phrase_value_property_dictionary_default
Doesn't happen again. And the confusing part is the referencing part only happens in global variabel.
"""
var phrase_value_property_dictionary: Dictionary = phrase_value_property_dictionary_default.duplicate(true);


func start_input_control():
	$SubmittedPhraseConfirmationDialog.get_cancel().connect("pressed", self, "confirmation_cancelled");
	$SubmittedPhraseConfirmationDialog.get_close_button().connect("pressed", self, "confirmation_cancelled");
	$InputVBoxContainer/TypingControl.change_line_edit_length(730);
	$InputVBoxContainer/TypingControl.change_option_button_length(250)
	$InputVBoxContainer/TypingControl.move_line_edit_anchor();
	$InputVBoxContainer/PropertyHBoxContainer/SpellingSoundHBoxContainer.start_listening();
	$InputVBoxContainer/PropertyHBoxContainer/WordImageHBoxContainer.start_drawing();

"""
save_to_wav demos and this project seems to be different.
recording.save_to_wav("user://Test/Sound/test_sample.wav");  # Doesn't work
recording.save_to_wav("user://test_sample.wav"); # Works
"""
func _on_Spelling_Sound_HBoxContainer_recorded_spelling(recording):
	var temp_recording = recording.duplicate(true);
	phrase_value_property_dictionary.sound_path_n_sample[1] = temp_recording;


func _on_Word_Image_HBoxContainer2_uploaded_file(image):
	phrase_value_property_dictionary.image_path_n_the_image[1] = image;


func _on_TypingControl_text_phrase_typed(index, text):
	if(!text.empty()):
		$InputVBoxContainer/SubmitOrthographyButton.disabled = false;
	phrase_value_property_dictionary.phrase_text = text;
	phrase_value_property_dictionary.phrase_type_index = index;


func _on_Submit_Orthography_Button_pressed():
	var dialog_text_with_values = "Are you sure the data is correct? \n Type: {0} \n Text: {1} \n Sound: {2} \n Image: {3}";
	var dialog_text_format_values = [
		OrthographyRepository.PHRASETYPE.keys()[phrase_value_property_dictionary.phrase_type_index],
		phrase_value_property_dictionary.phrase_text,
		phrase_value_property_dictionary.sound_path_n_sample[1],
		phrase_value_property_dictionary.image_path_n_the_image[1]
		]
	$SubmittedPhraseConfirmationDialog.dialog_text = dialog_text_with_values.format(dialog_text_format_values);
	$SubmittedPhraseConfirmationDialog.popup_centered();
	$InputVBoxContainer/SubmitOrthographyButton.disabled = true;


"""
Both are the same. I just seeing something when doing debugging.
phrase_value_property_dictionary.merge(phrase_value_property_dictionary_default, true);
phrase_value_property_dictionary = phrase_value_property_dictionary_default.duplicate(true);
"""
func reset_everything_input():
	$InputVBoxContainer/TypingControl.reset_line_edit_text();
	$InputVBoxContainer/PropertyHBoxContainer/SpellingSoundHBoxContainer.reset_recorded_sample();
	$InputVBoxContainer/PropertyHBoxContainer/WordImageHBoxContainer.reset_uploaded_image();
	phrase_value_property_dictionary.merge(phrase_value_property_dictionary_default, true);


func confirmation_cancelled():
	reset_everything_input();


"""
Always remind my self. If there are error in the debugger it is my fault. Like today I thought the Godot that has bugs.
But it turns out me that wrong in putting the different variable. sound_path_n_sample swapped with image_path_n_the_image.
Yet I never figure out why I can't use just save_to_wav() to make the recursive directory. Unlike the demos project.
"""
func _on_SubmittedPhraseConfirmationDialog_confirmed():
	var path_format: Array = [OrthographyRepository.save_path,
	OrthographyRepository.PHRASETYPE.keys()[phrase_value_property_dictionary.phrase_type_index].capitalize(),
	phrase_value_property_dictionary.phrase_text.capitalize()];
	var sound_path: String = "{0}Data/{1}/{2}/Sound/{2}.wav".format(path_format);
	var image_path: String = "{0}Data/{1}/{2}/Image/{2}.png".format(path_format);
	# Making the folder so it can't return error.
	var temp_dir = Directory.new();
	temp_dir.open(path_format[0]);
	temp_dir.make_dir_recursive("Data/{1}/{2}/Sound".format(path_format));
	temp_dir.make_dir_recursive("Data/{1}/{2}/Image".format(path_format));

	
	if(not phrase_value_property_dictionary.sound_path_n_sample[1] == null):
		phrase_value_property_dictionary.sound_path_n_sample[1].save_to_wav(sound_path);
		phrase_value_property_dictionary.sound_path_n_sample[0] = sound_path;
	
	if(not phrase_value_property_dictionary.image_path_n_the_image[1] == null):
		phrase_value_property_dictionary.image_path_n_the_image[1].save_png(image_path);
		phrase_value_property_dictionary.image_path_n_the_image[0] = image_path;
	
	emit_signal("phrase_value_property_submitted", phrase_value_property_dictionary.phrase_type_index,
	phrase_value_property_dictionary.phrase_text, phrase_value_property_dictionary.sound_path_n_sample[0],
	phrase_value_property_dictionary.image_path_n_the_image[0]);
	
	reset_everything_input();

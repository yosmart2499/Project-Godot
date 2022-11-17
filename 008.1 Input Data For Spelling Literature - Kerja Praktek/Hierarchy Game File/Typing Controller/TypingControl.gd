extends Control

var orthography_index_type: int = 0;
var orthography_text_type: String = "";

signal text_phrase_typed(index, text);

func reset_line_edit_text():
	$HBoxContainer/OrthoghrapyLineEdit.text = "";
	$HBoxContainer/PhraseTypeOptionButton.selected = 0;

func change_line_edit_length(length: int):
	$HBoxContainer/OrthoghrapyLineEdit.rect_min_size.x = length;

func change_option_button_length(length: int):
	$HBoxContainer/PhraseTypeOptionButton.rect_min_size.x = length;

func move_line_edit_anchor():
	$HBoxContainer.anchor_top = 0.5;
	$HBoxContainer.anchor_bottom = 0.5;
	$HBoxContainer.margin_bottom = $HBoxContainer/OrthoghrapyLineEdit.rect_size.y / 2;
	$HBoxContainer.margin_top = -$HBoxContainer/OrthoghrapyLineEdit.rect_size.y / 2;
	

func _on_Phrase_Type_OptionButton_item_selected(index):
	orthography_index_type = index;
	emit_signal("text_phrase_typed", orthography_index_type, orthography_text_type);


func _on_Orthoghrapy_LineEdit_text_changed(new_text):
	orthography_text_type = new_text;
	emit_signal("text_phrase_typed", orthography_index_type, orthography_text_type);

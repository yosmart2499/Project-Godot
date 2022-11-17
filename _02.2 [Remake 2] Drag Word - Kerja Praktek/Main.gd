extends Node

var screen_size;
var which_letters = 1;

func _ready():
	screen_size = get_viewport().size;
	$TouchArea.position = screen_size/2;
	$TouchArea.position.y += 100;
	$TouchArea.connect("send_word", self, "word_reciever");
	$TouchArea.connect("letters_touched", self, "letters_reciever");
	$TouchArea.change_letters($VocabContainers.given_four_letters[which_letters].to_upper());
	$VocabLabel.display_array_vocab($VocabContainers.give_every_word_dict($VocabContainers.given_four_letters[which_letters]), -1);

func word_reciever(word):
	if(word.empty()):
		return;
	$DisplayLabel.toggle_displayed();
	var index_right_word = $VocabContainers.where_word_in_dict(word, $VocabContainers.given_four_letters[which_letters]);
	$VocabLabel.display_array_vocab($VocabContainers.give_every_word_dict($VocabContainers.given_four_letters[which_letters]), index_right_word);

func letters_reciever(letters):
	$DisplayLabel.show_text(letters);

func toggle_hide_main_game():
	$TouchArea.visible = !$TouchArea.visible;
	$DisplayLabel.visible = !$DisplayLabel.visible;
	$DrawMousePath.visible = !$DrawMousePath.visible;
	$VocabLabel.visible = !$VocabLabel.visible;
	$RestartButton.visible = !$RestartButton.visible;

func _on_LevelControl_chosen_level(level):
	toggle_hide_main_game();
	which_letters = level;
	$TouchArea.change_letters($VocabContainers.given_four_letters[which_letters].to_upper());
	$VocabLabel.display_array_vocab($VocabContainers.give_every_word_dict($VocabContainers.given_four_letters[which_letters]), -1);


func _on_RestartButton_pressed():
	get_tree().reload_current_scene();

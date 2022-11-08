extends Node
class_name VocabContainers

var given_four_letters = ["word", "loop"];
var every_word_dict = {
	given_four_letters[0] : ["word", "dow", "row", "dor", "rod"],
	given_four_letters[1] : ["loop", "polo", "pool", "lop", "pol", "poo", "loo"],
}

func where_word_in_dict(letters, which_letter):
	var word_dict = every_word_dict[which_letter]
	return word_dict.find(letters.to_lower());


func give_every_word_dict(which_letter):
	return every_word_dict[which_letter];

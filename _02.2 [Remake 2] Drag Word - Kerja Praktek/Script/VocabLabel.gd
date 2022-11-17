extends Label
class_name VocabLabel

var answered_word_index;

func _ready():
	self.hide();
	answered_word_index = [];

func display_array_vocab(vocab_arr, index_vocab):
	self.text = "";
	for word in vocab_arr:
		var display_text = "";
		if(vocab_arr[index_vocab] == word && index_vocab != -1):
			display_text = word.to_upper()  + " [^] " + "\n";
			if(!answered_word_index.has(index_vocab)):
				answered_word_index.append(index_vocab);
		else:
			display_text = word.to_upper()  + " [ ] " + "\n";
		
		for index in answered_word_index:
			if(word == vocab_arr[index]):
				display_text = word.to_upper()  + " [^] " + "\n";
				
		self.text += display_text;

func reset_answered_word():
	answered_word_index = [];

extends Button

signal emit_letter(letter);

var letter_signal;
var screen_size;

func change_letterbutton_position(pos):
	self.rect_position = pos;

func change_letterbutton_text(letter):
	self.text = letter;
	letter_signal = letter;

func _on_LetterButton_pressed():
	emit_signal("emit_letter", letter_signal);

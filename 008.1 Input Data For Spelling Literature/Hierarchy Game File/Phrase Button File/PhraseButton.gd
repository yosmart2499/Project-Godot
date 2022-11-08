extends Button

signal send_text_button(button_text);

func _on_PhraseButton_pressed():
	emit_signal("send_text_button", self.text);

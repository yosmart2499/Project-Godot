extends Node2D

export (PackedScene) var letter_scene;

var word = "";

signal word_confirmned(word);

func create_4letter_path_system(letters):
	var iteration = 0;
	for letter_element in letters:
		var letter = letter_scene.instance();
		letter.set_letter_label(letter_element);
		letter.connect("letter_touched", self, "letter_touched_receiver");
		
		if(iteration == 0):
			letter.position += Vector2(0,-$LetterHolder.rect_size.y/4);
		elif(iteration == 1):
			letter.position += Vector2($LetterHolder.rect_size.x/4,0);
		elif(iteration == 2):
			letter.position += Vector2(0,$LetterHolder.rect_size.y/4);
		elif(iteration == 3):
			letter.position += Vector2(-$LetterHolder.rect_size.x/4,0);
		
		add_child(letter);
		iteration += 1;
		
func letter_touched_receiver(letter):
	word += letter;

func _on_MouseController_mouse_reset():
	get_tree().call_group("letters", "toggle_input");
	emit_signal("word_confirmned", word);
	word = "";

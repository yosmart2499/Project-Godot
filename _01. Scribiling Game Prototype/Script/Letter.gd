extends CanvasLayer

export (PackedScene) var letterbutton_scene;

var margin = 0;
var screen_size;

func _ready():
	screen_size = get_viewport().size;

func summon_letterbutton(given_word):
	for letter in given_word:
		create_letters_button(letter);
		margin += screen_size.x / given_word.length();

func create_letters_button(letter):
		var letters_node = letterbutton_scene.instance();
		letters_node.connect("emit_letter", self, "receive_letter_signal");
		letters_node.change_letterbutton_text(letter);
		letters_node.change_letterbutton_position(Vector2(0 + margin, screen_size.y/1.5));
		add_child(letters_node);

func receive_letter_signal(letter_signal):
	$LetterLabel.rect_position = Vector2(screen_size.x/2 - $LetterLabel.rect_size.x/2 - 32, screen_size.y/3);
	print($LetterLabel.rect_size.x);
	$LetterLabel.add_letterlabel(letter_signal);

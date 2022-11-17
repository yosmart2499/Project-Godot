extends Node

var screen_size;

func _ready():
	screen_size = get_viewport().size;
	$LetterSection.summon_letterbutton("ratatouille".to_upper());

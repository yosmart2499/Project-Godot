extends Node

export var gameplay_scene: PackedScene = preload("res://Modules/GameplayMain.tscn");
export var tutorial_scene: PackedScene = preload("res://Modules/Tutorial/Tutorial.tscn");

var tutorial_showed: bool = false;

func game_over() -> void:
	self.get_child(1).queue_free();
	$MainMenu.show();

func _on_MainMenu_start_game() -> void:
	$MainMenu.hide();
	if(not tutorial_showed):
		var tutorial: Node = self.tutorial_scene.instance();
		self.add_child(tutorial);
		yield(tutorial, "tree_exited");
		tutorial_showed = true;
	
	var gameplay: Node = self.gameplay_scene.instance();
	self.add_child(gameplay);

func _on_MainMenu_quit_game() -> void:
	get_tree().quit();



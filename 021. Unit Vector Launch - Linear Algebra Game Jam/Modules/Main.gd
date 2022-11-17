extends Node

export var gameplay_scene: PackedScene = preload("res://Modules/GameplayMain.tscn");

func game_over() -> void:
	self.get_child(1).queue_free();
	$MainMenu.show();

func _on_MainMenu_start_game() -> void:
	var gameplay: Node = self.gameplay_scene.instance();
	self.add_child(gameplay);
	$MainMenu.hide();

func _on_MainMenu_quit_game() -> void:
	get_tree().quit();



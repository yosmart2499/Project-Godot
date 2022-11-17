extends Node2D

export var baloon_scene: PackedScene = preload("res://Modules/Pickups/Baloon/Baloon.tscn");

onready var screen_size: Vector2 = get_viewport().get_visible_rect().size;

func give_random_pos() -> Vector2:
	return Vector2(rand_range(0, self.screen_size.x), rand_range(0, self.screen_size.y));

func _on_Timer_timeout():
	var baloon_inst: Area2D = baloon_scene.instance();
	baloon_inst.position = give_random_pos();
	self.add_child(baloon_inst);

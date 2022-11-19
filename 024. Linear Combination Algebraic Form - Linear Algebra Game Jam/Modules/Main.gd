extends Node

onready var screen_size: Vector2 = get_viewport().get_visible_rect().size;

func _ready() -> void:
	$PlayerKinematic.position = self.screen_size / 2;

extends Node

export var screen_navigator: Resource;

var current_screen;

onready var ref_navigator: ScreenNavigator = (screen_navigator as ScreenNavigator);

func _ready() -> void:
	print(UserAccess.connect("change_screen", self, "change_scene"));
	update_screen();
	self.add_child(current_screen);

func change_scene() -> void:
	print(UserAccess.Category.keys()[UserAccess.user_type]);
	print(UserAccess.Scene.keys()[UserAccess.screen_type]);
	self.remove_child(self.current_screen);
	update_screen()
	self.add_child(self.current_screen);

func update_screen() -> void:
	self.current_screen = self.ref_navigator.produce_instance(UserAccess.user_type, UserAccess.screen_type)

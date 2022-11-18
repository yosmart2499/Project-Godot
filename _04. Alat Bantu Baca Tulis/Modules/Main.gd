extends Node

export var screen_navigator: Resource = preload("res://Assets/Resources/screen_navigator.tres");

var current_screen;

onready var ref_navigator: ScreenNavigator = (screen_navigator as ScreenNavigator);
onready var back_button: Button = preload("res://Modules/UI/Step Back/BackBtn.tscn").instance();

func _ready() -> void:
	print(UserAccess.connect("change_screen", self, "change_scene"));
	update_screen();
	self.add_child(current_screen);

func _notification(what: int) -> void:
	if(what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		SaveLoading.save_to_resource();

func change_scene() -> void:
	UserAccess.load_repo();
	print(UserAccess.Category.keys()[UserAccess.user_type]);
	print(UserAccess.Scene.keys()[UserAccess.screen_type]);
	self.current_screen.queue_free();
	if(self.back_button.is_inside_tree()):
		self.current_screen.remove_child(self.back_button);
	update_screen()
	self.add_child(self.current_screen);
	if(UserAccess.screen_type != -1):
		self.current_screen.add_child(self.back_button);

func update_screen() -> void:
	self.current_screen = self.ref_navigator.produce_instance();

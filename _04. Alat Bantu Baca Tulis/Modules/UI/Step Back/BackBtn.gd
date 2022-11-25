extends Button

export var screen_navigator: Resource;

onready var ref_navigator: ScreenNavigator = (screen_navigator as ScreenNavigator);

func _ready() -> void:
	UserAccess.connect("user_selected", self, "back_button_show");
	UserAccess.connect("change_screen", self, "back_button_show");

func back_button_show() -> void:
	if(UserAccess.user_type == -1 || UserAccess.screen_type == UserAccess.Scene.GAME_QUESTIONNAIRE):
		self.hide();
	else:
		self.show();

func _on_BackBtn_pressed() -> void:
	if(UserAccess.screen_type == UserAccess.Scene.MONSTER_MARKET):
		self.get_parent().get_parent().reinstance_monster_placeholder();
	self.ref_navigator.step_back();

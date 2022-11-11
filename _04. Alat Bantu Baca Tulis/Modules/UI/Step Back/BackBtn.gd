extends Button

export var screen_navigator: Resource;

onready var ref_navigator: ScreenNavigator = (screen_navigator as ScreenNavigator);

func _ready():
	print(UserAccess.connect("user_selected", self, "back_button_show"));

func back_button_show():
	if(UserAccess.user_type == -1):
		hide();
	else:
		show();

func _on_BackBtn_pressed():
	self.ref_navigator.step_back()

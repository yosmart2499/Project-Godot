extends TouchScreenButton
class_name DragScreenWordSystem

var on_area = false;
var disbaled = false;

func _ready():
	self.connect("pressed", self, "_on_self_pressed");
	self.connect("released", self, "_on_self_released");

func toggle_functionality():
	disbaled = !disbaled;

func is_on_area():
	if(disbaled):
		return;
	if(!on_area):
		return;
	on_area = false;
	return true;

func _on_self_pressed():
	on_area = true;

func _on_self_released():
	on_area = false;

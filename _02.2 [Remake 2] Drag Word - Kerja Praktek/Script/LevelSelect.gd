extends Button
class_name SelectedLevel

export (int) var level;
signal level_selected(level);

func _ready():
	self.connect("pressed", self, "_on_select_level");
	self.text = str(level);
	self.hide();
	self.pressed = true;
	self.connect("level_selected", get_parent(), "play_selected_level");

func change_position(pos):
	self.rect_position = pos;
	self.show();

func other_level_selected():
	self.disabled = false;

func _on_select_level():
#	self.connect("level_selected", get_parent(), "play_selected_level");
	emit_signal("level_selected", level);
	get_tree().call_group("levelselect", "other_level_selected");
	yield(get_tree().create_timer(0.001), "timeout");
	self.disabled = true;

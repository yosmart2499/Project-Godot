extends Label
class_name DisplayLabel

var blip_display_timer = Timer.new();
var being_displayed = false;

func _ready():
	self.hide();
	add_child(blip_display_timer);
	blip_display_timer.one_shot = true;
	blip_display_timer.start();
	blip_display_timer.connect("timeout", self, "_on_self_timeout");

func show_text(word):
	self.text = word;
	being_displayed = true;

func toggle_displayed():
	being_displayed = !being_displayed;
	yield(get_tree().create_timer(1), "timeout");
	blip_display_timer.start();

# Bug where you click fast enough where not area of word.
func _on_self_timeout():
	if(being_displayed):
		return;
	self.text = "|";
	yield(get_tree().create_timer(1), "timeout");
	self.text = "";
	if(being_displayed):
		return;
	blip_display_timer.start();




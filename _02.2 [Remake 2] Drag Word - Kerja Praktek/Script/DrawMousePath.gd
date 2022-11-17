extends Line2D
class_name DrawMousePath

var wait_time = false;

func  _ready():
	self.hide();

func _input(event):
	if(wait_time):
		return;
	if(event is InputEventScreenDrag):
		self.add_point(event.position);
	if(event is InputEventMouseButton && event.is_pressed() == false):
		wait_time = true;
		yield(get_tree().create_timer(1), "timeout");
		wait_time = false;
		self.clear_points();

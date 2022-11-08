extends Label

func _ready():
	yield(get_tree().create_timer(1), "timeout");
	self.text = $"../../".first_stored_text;
	yield(get_tree().create_timer(1), "timeout");
	self.text = get_node("/root/Main").second_stored_text;

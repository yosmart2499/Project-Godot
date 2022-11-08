extends Label

func _process(_delta):
	update();

func _draw():
	if(self.text.empty()):
		return;
	draw_line(Vector2(0, self.rect_size.y), self.rect_size, Color.black, 2);

func add_letterlabel(letter):
	self.text += letter;

func reset_letterlabel():
	self.text = "";

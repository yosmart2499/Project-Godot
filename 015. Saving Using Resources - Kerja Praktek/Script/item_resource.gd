extends Object
class_name ItemResource

export var text: String;
export var type: String;
export var img: ImageTexture;

func _init(cons_text: String = "", cons_type: String = ""):
	self.text = cons_text;
	self.type = cons_type;

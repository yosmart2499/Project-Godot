extends Object
class_name GraphemeItem

export var text: String;
export var type: String;
export var spelling: Array;
export var pronounce: AudioStreamSample;
export var text_image: ImageTexture;

func _init(cons_text: String = "", cons_type: String  = "", cons_spelling: Array = [], _cons_pronounce: AudioStreamSample = null, _cons_image: ImageTexture = null):
	self.text = cons_text;
	self.type = cons_type;
	self.spelling = cons_spelling;

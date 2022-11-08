extends Object
class_name GraphemeItem

export var text: String;
export var type: String;
export var spelling: Array;
export var pronounce_text: String;
export var pronounce_sound: AudioStreamSample;

func _init(cons_text: String, cons_type: String, cons_spelling: Array = [], cons_pron_text: String = ""):
	self.text = cons_text;
	self.type = cons_type;
	self.spelling = cons_spelling;
	self.pronounce_text = cons_pron_text;

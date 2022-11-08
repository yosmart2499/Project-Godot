extends Object
class_name CostumObject

export var text: String;
export var type: String;
export var spelling: Array;
export var sample: AudioStreamSample;

func _init(cons_text: String = "", cons_type: String = ""):
	self.text = cons_text;
	self.type = cons_type;

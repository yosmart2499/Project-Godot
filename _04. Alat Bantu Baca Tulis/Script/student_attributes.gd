extends Resource
class_name StudentAttributes

export var berry_pocket: int = 0;

var berry_collected: int = 0;

func add_collected_berry(value: int) -> void:
	self.berry_collected += value;

func add_berry_to_pocket() -> void:
	self.berry_pocket += self.berry_collected;
	self.berry_collected = 0;

func deduct_berry(value: int) -> void:
	self.berry_pocket = max(0, self.berry_pocket - value);

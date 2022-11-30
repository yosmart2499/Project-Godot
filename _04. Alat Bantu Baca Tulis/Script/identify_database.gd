extends Resource
class_name IdentifyDatabase

export var selected_grapheme: Array = [];

signal selected_change();

func add_selected_item(grapheme: Object) -> void:
	if(self.find_selected_item(grapheme)):
		self.remove_selected_item(grapheme);
	self.selected_grapheme.append({"text" : grapheme.text, "type" : grapheme.type});
	self.emit_signal("selected_change");

func remove_selected_item(grapheme: Object) -> void:
	for item in self.selected_grapheme:
		if(item.text == grapheme.text and item.type == grapheme.type):
			self.selected_grapheme.remove(self.selected_grapheme.find(item));
			self.emit_signal("selected_change");

func find_selected_item(grapheme: Object) -> bool:
	for item in self.selected_grapheme:
		if(item.text == grapheme.text and item.type == grapheme.type):
			return true;
	return false;

func give_four_rand_selected() -> Array:
	var rand_selected: Array = [];
	
	var rand_item_dict: Dictionary;
	for _i in range(4):
		rand_item_dict = self.selected_grapheme[randi() % self.selected_grapheme.size()];
		while(rand_item_dict in rand_selected):
			rand_item_dict = self.selected_grapheme[randi() % self.selected_grapheme.size()];
		rand_selected.append(rand_item_dict);
		
	return rand_selected;

func show_debug() -> void:
	var counter: int = 0;
	print();
	for grapheme in self.selected_grapheme:
		print(String(counter) + " - " + grapheme.text + " - " + grapheme.type);
		counter += 1;
	print();

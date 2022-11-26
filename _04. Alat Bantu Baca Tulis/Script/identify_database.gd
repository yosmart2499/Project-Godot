extends Resource
class_name IdentifyDatabase

export var selected_grapheme: Array = [];

signal selected_change();

func add_selected_item(grapheme: Object) -> void:
	if(self.find_selected_item(grapheme)):
		self.remove_selected_item(grapheme);
	self.selected_grapheme.append(grapheme.text);
	self.emit_signal("selected_change");

func remove_selected_item(grapheme: Object) -> void:
	self.selected_grapheme.remove(self.selected_grapheme.find(grapheme.text));
	self.emit_signal("selected_change");

func find_selected_item(grapheme: Object) -> bool:
	if(grapheme.text in self.selected_grapheme):
		return true;
	else:
		return false;

func give_four_rand_selected() -> Array:
	var rand_selected: Array = [];
	
	var rand_item: Object;
	for _i in range(4):
		rand_item = self.selected_grapheme[randi() % self.selected_grapheme.size()];
		while(rand_item in rand_selected):
			rand_item = self.selected_grapheme[randi() % self.selected_grapheme.size()];
		rand_selected.append(rand_item);
		
	return rand_selected;

func show_debug() -> void:
	var counter: int = 0;
	print();
	for grapheme in self.selected_grapheme:
		print(String(counter) + " - " + grapheme);
		counter += 1;
	print();

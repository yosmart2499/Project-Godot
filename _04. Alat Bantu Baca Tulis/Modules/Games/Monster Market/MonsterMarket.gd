extends Control

export var student_att_resource: Resource = preload("res://Assets/Resources/student_attributes.tres");

var save_path: String = "user://student_attributes.tres";
var monster_index: int = 0;

onready var monsters_selection: Array = $MonsterContainer.get_children();

func _ready() -> void:
	if(UserAccess.user_type == UserAccess.Category.STUDENT):
		$UserLabel.text = "Siswa";
	else:
		$UserLabel.text = "Guru";
	self.student_att_resource = SaveLoading.load_from_resource_general(self.student_att_resource, self.save_path);
	$PriceTag.text = String(self.monsters_selection[self.monster_index].berry_cost) + " Berry";
	$PocketBerry.text = "Kantong: " + String(student_att_resource.berry_pocket);
	$BuyButton.disabled = self.monsters_selection[self.monster_index].bought;
	self.resize_monster();

func resize_monster() -> void:
	for monster in self.monsters_selection:
		monster.scale = Vector2.ONE * 5;

func hide_every_monster() -> void:
	for monster in self.monsters_selection:
		monster.hide();

func _on_Previous_pressed() -> void:
	self.hide_every_monster();
	self.monster_index = wrapi(self.monster_index - 1, 0, self.monsters_selection.size());
	self.monsters_selection[self.monster_index].show();
	$PriceTag.text = String(self.monsters_selection[self.monster_index].berry_cost) + " Berry";
	if(self.monsters_selection[self.monster_index].bought):
		$BuyButton.disabled = true;
	else:
		$BuyButton.disabled = false;

func _on_Next_pressed() -> void:
	self.hide_every_monster();
	self.monster_index = wrapi(self.monster_index + 1, 0, self.monsters_selection.size());
	self.monsters_selection[self.monster_index].show();
	$PriceTag.text = String(self.monsters_selection[self.monster_index].berry_cost) + " Berry";
	if(self.monsters_selection[self.monster_index].bought):
		$BuyButton.disabled = true;
	else:
		$BuyButton.disabled = false;

func _on_BuyButton_pressed():
	if(self.student_att_resource.deduct_berry(self.monsters_selection[self.monster_index].berry_cost)):
		self.student_att_resource.show_debug();
		$PocketBerry.text = "Pocket: " + String(student_att_resource.berry_pocket);
		self.monsters_selection[self.monster_index].bought_and_display();
		$BuyButton.disabled = true;

func _on_MonsterMarket_tree_exited():
	SaveLoading.save_to_resource_general(self.student_att_resource, self.save_path);

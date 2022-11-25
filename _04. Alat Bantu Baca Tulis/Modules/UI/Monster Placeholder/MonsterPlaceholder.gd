extends Node

var bought_monsters: Array = []
var move_direction: Vector2 = Vector2.RIGHT;

onready var screen_size: Vector2 = get_viewport().get_visible_rect().size;
onready var all_monsters: Array = $MonsterContainer.get_children();

func _ready() -> void:
	self.move_to_corner();
	self.hide_not_bought();

func _process(delta: float) -> void:
	if(self.bought_monsters == []):
		return;
	for monster in self.bought_monsters:
		monster.move_position(delta);

func hide_not_bought() -> void:
	for monster in all_monsters:
		if(monster.bought):
			bought_monsters.append(monster);
			monster.show();
			monster.rotate(PI);
		else:
			monster.hide();

func get_monster_texture_size(node: Node2D) -> Vector2:
	return node.get_node("Image").texture.get_size() * 0.5;

func move_to_corner() -> void:
	self.all_monsters[0].position = Vector2.ZERO + self.get_monster_texture_size(self.all_monsters[0]);
	self.all_monsters[1].position = Vector2(self.screen_size.x, 0) + Vector2(-self.get_monster_texture_size(self.all_monsters[1]).x, self.get_monster_texture_size(self.all_monsters[1]).y);
	self.all_monsters[2].position = self.screen_size - self.get_monster_texture_size(self.all_monsters[2]);
	self.all_monsters[3].position = Vector2(0, self.screen_size.y) + Vector2(self.get_monster_texture_size(self.all_monsters[1]).x, -self.get_monster_texture_size(self.all_monsters[1]).y);

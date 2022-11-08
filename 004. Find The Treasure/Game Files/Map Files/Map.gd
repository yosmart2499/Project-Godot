extends Node2D

export (PackedScene) var grid_scene;
export (PackedScene) var treasure_scene;
export (PackedScene) var bomb_scene;

var counter = 0;

signal picked_treasure;
signal bomb_touched;
signal out_of_bounds;

func start_the_map(pos):
	$ProduceMap.start_produce(pos);

func stop_the_map():
	$ProduceMap.stop_produce();
	get_tree().call_group("treasureNbomb", "deactivate_pickable");
	get_tree().call_group("grids", "deactivate_pickable");
	yield(get_tree().create_timer(2), "timeout");
	get_tree().call_group("treasureNbomb", "queue_free");
	get_tree().call_group("grids", "queue_free");

func _on_ProduceMap_produce_grid():
	var grid = grid_scene.instance();
	grid.position = $ProduceMap.position;
	call_deferred("add_child", grid);
	
	if(counter % 10 == 0):
		put_treasureORbomb(grid.position);
	counter += 1;

func put_treasureORbomb(grid_pos):
	var random_treasureORbomb = true;
	if(randi() % 2):
		random_treasureORbomb = false;
	
	if(random_treasureORbomb):
		var treasure = treasure_scene.instance();
		treasure.position = grid_pos;
		$TreasureNBombContainer.call_deferred("add_child", treasure);
		treasure.connect("treasure_picked", self, "treasure_picked_receiver");
	else:
		var bomb = bomb_scene.instance();
		bomb.position = grid_pos;
		$TreasureNBombContainer.call_deferred("add_child", bomb);
		bomb.connect("bomb_touched", self, "bomb_touched_receiver");

func treasure_picked_receiver():
	emit_signal("picked_treasure");

func bomb_touched_receiver():
	emit_signal("bomb_touched");

func _on_ProduceMap_produce_screen_exited():
	stop_the_map();
	emit_signal("out_of_bounds")

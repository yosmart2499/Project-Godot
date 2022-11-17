extends Node;

export (PackedScene) var mob_scene;
var score;

func _ready():
	randomize();

# Want to try if I can call another function with group_call() method. Rather making a instance.
#	print(get_tree().get_nodes_in_group("call_func_other_node"));
#	print(get_tree().get_nodes_in_group("call_func_other_node")[1].say_hello());

func game_over():
	$ScoreTimer.stop();
	$MobTimer.stop();
	$HUD.show_game_over();
	$Music.stop();
	$DeathSound.play();

func new_game():
	score = 0;
	$Player.start($StartPosition.position);
	$StartTimer.start();
	$HUD.update_score(score);
	$HUD.show_message("Get Ready!");
	get_tree().call_group("mobs", "queue_free");
	# Want to try if I can get another child of instance and access the timer node.
#	yield($HUD/MessageTimer, "timeout");
	$Music.play();

func _on_MobTimer_timeout():
	var mob = mob_scene.instance();
	# The code below basicly is the same as the above but if you look at in debugger you see how we created PackedScene object and fill it or instance it with mob_scene
#	var mob = PackedScene.new();
#	mob = mob_scene.instance();
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation");
	

	mob_spawn_location.offset = randi();
	var direction = mob_spawn_location.rotation + PI / 2;
	mob.position = mob_spawn_location.position;
	direction += rand_range(-PI / 4, PI / 4);

## Editing
#	# PI uses radians. It will be confusing but search about radians in Khan Academy
#	# And don't use degree to calculate this. Just use radians and PI
#	# The code below just me want to see what if offset reaches the maximum plus 1
#	mob_spawn_location.offset = 2382;
#	# The code below will put the mobs in bottom path of the game screen
#	mob_spawn_location.offset = 1300;
#	# The code below show the range of the radian is PI radians and -PI radians
#	# But how many number in positive it's just 2PI radians = 360 degrees
#	var see_rotation = mob_spawn_location.rotation;
#	# Code below basicly makes the the direction to turn 90 degrees to the right but in radians it's PI/2 keep that in mind
#	var direction = mob_spawn_location.rotation + PI / 2;
#	mob.position = mob_spawn_location.position;
#	# Same here the direction will be random between -45 degrees and 45 degrees after turning right. But in radians it's PI/4 radians = 45 degrees
#	direction += rand_range(-PI / 4, PI / 4);
# REMEMBER WHEN PLAYING rotation property in Godot ALWAYS think it as radians

	mob.rotation = direction;
	mob.call_function("wubba lubba dub dub");
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0);
	mob.linear_velocity = velocity.rotated(direction);
	
#	print(Vector2(100, 0).rotated(direction));
# Linear Velocity is a constant movement of rigid body
# Rotated it means velocity rotate to same direction with math formula to rotating Vector2 to same direction as mobs
#	var velocity = Vector2(rand_range(150.0, 250.0), 0.0);
#	mob.linear_velocity = velocity;
	
	add_child(mob);

func _on_ScoreTimer_timeout():
	score += 1;
	$HUD.update_score(score);


func _on_StartTimer_timeout():
	$MobTimer.start();
	$ScoreTimer.start();

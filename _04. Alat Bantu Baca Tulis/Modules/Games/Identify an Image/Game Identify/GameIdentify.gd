extends Control

export var identify_databse_res: Resource = preload("res://Assets/Resources/identify_database.tres");
export var student_att_resource: Resource = preload("res://Assets/Resources/student_attributes.tres");

const save_path_student: String = "user://student_attributes.tres";
const save_path_identify: String = "user://identify_database.tres";
const berry_increase_per_question: int = 50;

var given_graphemes: Array = [];
var given_answer: Array = [];
var answer: Object;
var counter_question: int = 0;
var berry_get: int = 50;
var berry_collected: int = 0;
var lives: int = 3;

signal lives_changed();

func _ready() -> void:
	self.identify_databse_res = SaveLoading.load_from_resource_general(self.identify_databse_res, self.save_path_identify);
	self.student_att_resource = SaveLoading.load_from_resource_general(self.student_att_resource, self.save_path_student)
	self.give_random_grapheme();
	self.change_display();
	self.connect("lives_changed", self, "watch_over_lives_left");

func watch_over_lives_left() -> void:
	if(self.lives < 1):
		self.student_att_resource.add_collected_berry(self.berry_collected);
		SaveLoading.save_to_resource_general(self.student_att_resource, self.save_path_student);
		UserAccess.set_screen(UserAccess.Scene.WINNING_SCREEN);
		return;
	else:
		$LivesLeft.text = "Lives: " + String(self.lives);

func give_random_grapheme() -> void:
	given_graphemes = self.identify_databse_res.give_four_rand_selected();
	self.answer = self.random_from_given_grapheme();
	while(self.answer in given_answer):
		self.answer = self.random_from_given_grapheme();
	self.given_answer.append(self.answer);

func change_display() -> void:
	$VBoxContainer/BerryCollected.text = "Collected: " + String(self.berry_collected);
	$VBoxContainer/BerryGet.text = "Berry: " + String(self.berry_get);
	$HBoxContainer/VBoxContainer/WordLabel.text = self.answer.text;
	$HBoxContainer/VBoxContainer/SpellingLabel.text = PoolStringArray(self.answer.spelling).join("-");
	$HBoxContainer/VBoxContainer/TypeLabel.text = self.answer.type;
	$HBoxContainer/GridContainer/BoxIdentify1/TextureRect.texture = \
	UserAccess.ref_ortho_repo.find_item(given_graphemes[0].text, given_graphemes[0].type).text_image;
	$HBoxContainer/GridContainer/BoxIdentify2/TextureRect.texture = \
	UserAccess.ref_ortho_repo.find_item(given_graphemes[1].text, given_graphemes[1].type).text_image;
	$HBoxContainer/GridContainer/BoxIdentify3/TextureRect.texture = \
	UserAccess.ref_ortho_repo.find_item(given_graphemes[2].text, given_graphemes[2].type).text_image;
	$HBoxContainer/GridContainer/BoxIdentify4/TextureRect.texture = \
	UserAccess.ref_ortho_repo.find_item(given_graphemes[3].text, given_graphemes[3].type).text_image;
	

func random_from_given_grapheme() -> Object:
	var temp_rand: Dictionary = self.given_graphemes[randi() % 4];
	return UserAccess.ref_ortho_repo.find_item(temp_rand.text, temp_rand.type);

func _on_GivenTimer_timeout() -> void:
	self.counter_question += 1;
	if(self.counter_question > 3):
		self.student_att_resource.add_collected_berry(self.berry_collected);
		SaveLoading.save_to_resource_general(self.student_att_resource, self.save_path_student);
		UserAccess.set_screen(UserAccess.Scene.WINNING_SCREEN);
		return;
	self.berry_get += self.berry_increase_per_question;
	self.give_random_grapheme();
	self.change_display();

func reset_timer():
	self._on_GivenTimer_timeout();
	self._on_SecondTimer_timeout();
	$GivenTimer.start();
	$SecondTimer.start();

func _on_SecondTimer_timeout() -> void:
	$VBoxContainer/TimerLabel.text = "Timer: " + String(int($GivenTimer.time_left));

func _on_Answer1_pressed():
	if(self.given_graphemes[0].text == self.answer.text):
		self.berry_collected += self.berry_get;
		self.reset_timer();
	else:
		self.lives -= 1;
		emit_signal("lives_changed");

func _on_Answer2_pressed():
	if(self.given_graphemes[1].text == self.answer.text):
		self.berry_collected += self.berry_get;
		self.reset_timer();
	else:
		self.lives -= 1;
		emit_signal("lives_changed");

func _on_Answer3_pressed():
	if(self.given_graphemes[2].text == self.answer.text):
		self.berry_collected += self.berry_get;
		self.reset_timer();
	else:
		self.lives -= 1;
		emit_signal("lives_changed");

func _on_Answer4_pressed():
	if(self.given_graphemes[3].text == self.answer.text):
		self.berry_collected += self.berry_get;
		self.reset_timer();
	else:
		self.lives -= 1;
		emit_signal("lives_changed");

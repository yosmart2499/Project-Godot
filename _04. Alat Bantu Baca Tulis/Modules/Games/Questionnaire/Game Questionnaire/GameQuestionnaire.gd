extends Control

export var questionnaire_resource: Resource = preload("res://Assets/Resources/questionnaire_database.tres");
export var student_att_resource: Resource = preload("res://Assets/Resources/student_attributes.tres");

var save_path: String = "user://student_attributes.tres";
var berry_collected: int = 0;
var predetermined_question: Array;
var selected_index: int = 0;
var selected_answer: int = -1;
var item_selected: QuestionnaireItem;

func _ready() -> void:
	self.student_att_resource = SaveLoading.load_from_resource_general(self.student_att_resource, self.save_path);
	self.questionnaire_resource = SaveLoading.load_from_resource();
	self.questionnaire_resource.show_debug();
	self.predetermined_question = self.questionnaire_resource.give_random_questions(4);
	if(self.predetermined_question == []):
		return;
	self.change_display();

func change_display() -> void:
	self.item_selected = self.predetermined_question[self.selected_index];
	$BerryCollected.text = "Collected: " + String(self.berry_collected);
	$BerryGet.text = "Berry: " + String(self.item_selected.berry_weight);
	$QuestionsLeft.text = "Questions: " + String(self.predetermined_question.size() - self.selected_index);
	$VBoxContainer/Question.text = self.item_selected.question;
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer.text = self.item_selected.answers[0];
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer2.text = self.item_selected.answers[1];
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer3.text = self.item_selected.answers[2];
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer4.text = self.item_selected.answers[3];
	self.unpressed_all_button();

"""
When queue_free() is launched Godot still
run the rest of the code of the function below it.
"""

func _on_QuestionTimer_timeout() -> void:
	if(self.selected_answer == self.item_selected.right_answer):
		self.berry_collected += self.item_selected.berry_weight;
		self.selected_answer = -1;
	if(self.selected_index + 1 >= self.predetermined_question.size()):
		self.student_att_resource.add_collected_berry(self.berry_collected);
		SaveLoading.save_to_resource_general(student_att_resource, save_path);
		UserAccess.set_screen(UserAccess.Scene.WINNING_SCREEN);
	else:
		self.selected_index += 1;
		self.change_display();

func _on_SecondTimer_timeout() -> void:
	if(int($QuestionTimer.time_left) < 10):
		$TimerLabel.text = "0" + String(int($QuestionTimer.time_left));
	else:
		$TimerLabel.text = String(int($QuestionTimer.time_left));

func unpressed_all_button() -> void:
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer.pressed = false;
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer2.pressed = false;
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer3.pressed = false;
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer4.pressed = false;

func _on_Answer_pressed() -> void:
	self.unpressed_all_button();
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer.pressed = true;
	self.selected_answer = 1;

func _on_Answer2_pressed():
	self.unpressed_all_button();
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer2.pressed = true;
	self.selected_answer = 2;

func _on_Answer3_pressed():
	self.unpressed_all_button();
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer3.pressed = true;
	self.selected_answer = 3;

func _on_Answer4_pressed():
	self.unpressed_all_button();
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer4.pressed = true;
	self.selected_answer = 4;

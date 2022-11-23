extends Control

export var questionnaire_resource: Resource = preload("res://Assets/Resources/questionnaire_database.tres");

var berry_collected: int = 0;
var predetermined_question: Array;
var selected_index: int = 0;

func _ready() -> void:
	self.questionnaire_resource = SaveLoading.load_from_resource();
	self.questionnaire_resource.show_debug();
	self.predetermined_question = self.questionnaire_resource.give_random_questions(2);
	self.change_display();

func change_display() -> void:
	var temp_item_selected: QuestionnaireItem = self.predetermined_question[self.selected_index];
	$BerryGet.text = "Berry: " + String(temp_item_selected.berry_weight);
	$QuestionsLeft.text = "Questions: " + String(self.predetermined_question.size() - self.selected_index);
	$VBoxContainer/Question.text = temp_item_selected.question;
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer.text = temp_item_selected.answers[0];
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer2.text = temp_item_selected.answers[1];
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer3.text = temp_item_selected.answers[2];
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer4.text = temp_item_selected.answers[3];
	self.unpressed_all_button();

"""
When queue_free() is launched Godot still
run the rest of the code of the function below it.
"""

func _on_QuestionTimer_timeout() -> void:
	if(self.selected_index + 1 >= self.predetermined_question.size()):
		self.queue_free();
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

func _on_Answer2_pressed():
	self.unpressed_all_button();
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer2.pressed = true;

func _on_Answer3_pressed():
	self.unpressed_all_button();
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer3.pressed = true;

func _on_Answer4_pressed():
	self.unpressed_all_button();
	$VBoxContainer/VBoxContainer2/CenterContainer/GridContainer/Answer4.pressed = true;

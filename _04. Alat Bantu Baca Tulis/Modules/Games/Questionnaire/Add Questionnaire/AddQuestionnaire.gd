extends Control

export var questionnaire_resource: Resource = preload("res://Assets/Resources/questionnaire_database.tres");

onready var text_ref: Array = [
	$VBoxContainer/Question,
	$VBoxContainer/HBoxContainer/VBoxContainer2/GridContainer/Answer,
	$VBoxContainer/HBoxContainer/VBoxContainer2/GridContainer/Answer2,
	$VBoxContainer/HBoxContainer/VBoxContainer2/GridContainer/Answer3,
	$VBoxContainer/HBoxContainer/VBoxContainer2/GridContainer/Answer4,
	$VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Answer,
	$VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer2/Berry,
];

func _ready() -> void:
	self.questionnaire_resource = SaveLoading.load_from_resource();
	self.questionnaire_resource.show_debug();
	if(UserAccess.user_type == UserAccess.Category.STUDENT):
		$UserLabel.text = "Siswa";
	else:
		$UserLabel.text = "Guru";

func _on_Confirm_pressed() -> void:
	if(self.text_ref[0].text.empty()):
		return;
	if(self.text_ref[1].text.empty()):
		return;
	if(self.text_ref[2].text.empty()):
		return;
	if(self.text_ref[3].text.empty()):
		return;
	if(self.text_ref[4].text.empty()):
		return;
	$Confirmation.popup_centered_ratio(0.3);

func _on_Confirmation_confirmed() -> void:
	self.questionnaire_resource.add_question(QuestionnaireItem.new(
		self.text_ref[0].text,
		[self.text_ref[1].text, self.text_ref[2].text, self.text_ref[3].text, self.text_ref[4].text],
		self.text_ref[5].value,
		self.text_ref[6].value
	));
	self.questionnaire_resource.show_debug();
	self.text_ref[0].text = "";
	self.text_ref[1].text = "";
	self.text_ref[2].text = "";
	self.text_ref[3].text = "";
	self.text_ref[4].text = "";
	self.text_ref[5].value = 1;
	self.text_ref[6].value = 0;
	SaveLoading.save_to_resource(questionnaire_resource);

func _on_Confirmation_about_to_show() -> void:
	var text_dialog: String = "Apa benar kamu mau membuat pertanyaan ini? \n \n" \
	+ "Pertanyaan: %s \n" % self.text_ref[0].text \
	+ "Jawaban 1: %s \n" % self.text_ref[1].text \
	+ "Jawaban 2: %s \n" % self.text_ref[2].text \
	+ "Jawaban 3: %s \n" % self.text_ref[3].text \
	+ "Jawaban 4: %s \n" % self.text_ref[4].text \
	+ "Jawaban Benar: %s \n" % self.text_ref[5].value \
	+ "Berry Diberikan: %s \n" % self.text_ref[6].value;
	
	$Confirmation.dialog_text = text_dialog.format(self.text_ref);

func _on_AddQuestion_tree_exited() -> void:
	SaveLoading.save_to_resource(questionnaire_resource);
	self.questionnaire_resource.show_debug();

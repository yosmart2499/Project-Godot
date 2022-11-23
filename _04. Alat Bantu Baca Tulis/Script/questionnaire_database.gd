extends Resource
class_name QuestionnaireDatabase

export var all_questions: Array;

func add_question(item: QuestionnaireItem) -> void:
	self.all_questions.append(item);

func give_random_questions(specified_length: int) -> Array:
	if(specified_length > self.all_questions.size()):
		return [];
	var appointed_question: Array = [];
	for _i in range(specified_length):
		var temp_question: QuestionnaireItem = self.all_questions[randi() % self.all_questions.size()];
		while(temp_question in appointed_question):
			temp_question = self.all_questions[randi() % self.all_questions.size()];
		appointed_question.append(temp_question);
	return appointed_question;

func show_debug() -> void:
	var counter: int = 0;
	for item in self.all_questions:
		print(String(counter) + " - " + item.question + " - " + String(item.answers)
		+ " - " +  String(item.right_answer) + " - " + String(item.berry_weight));

extends Object
class_name QuestionnaireItem

export var question: String;
export var answers: PoolStringArray;
export var right_answer: int;
export var berry_weight: int;

func _init(cons_question: String = "", cons_answers: PoolStringArray = [], cons_answer: int = -1, cons_berry: int = 0) -> void:
	self.question = cons_question;
	for _init in range(4):
		self.answers.append("temp");
	self.answers = cons_answers;
	self.right_answer = cons_answer;
	self.berry_weight = cons_berry;

func check_right_answer(param_answer: int) -> Array:
	if(param_answer == right_answer):
		return [self.answers[param_answer], self.berry_weight];
	else:
		return [];

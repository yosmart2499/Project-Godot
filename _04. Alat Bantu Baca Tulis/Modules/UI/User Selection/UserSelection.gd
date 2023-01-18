extends Control

func _on_StudentBtn_pressed() -> void:
	UserAccess.set_user(UserAccess.Category.STUDENT);
	UserAccess.set_screen(UserAccess.Scene.CHOOSE_FEATURE);


func _on_TeacherBtn_pressed() -> void:
	UserAccess.set_user(UserAccess.Category.TEACHER);
	UserAccess.set_screen(UserAccess.Scene.CHOOSE_FEATURE);

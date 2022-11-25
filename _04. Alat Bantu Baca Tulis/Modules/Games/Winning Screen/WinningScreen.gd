extends Control

export var student_att_resource: Resource = preload("res://Assets/Resources/student_attributes.tres");

var save_path: String = "user://student_attributes.tres";

func _ready():
	if(UserAccess.user_type == UserAccess.Category.STUDENT):
		$UserLabel.text = "Student";
	else:
		$UserLabel.text = "Teacher";
	self.student_att_resource = SaveLoading.load_from_resource_general(self.student_att_resource, self.save_path);
	$WinningLabel.text = "You've Collected \n {0} Berry!".format([self.student_att_resource.berry_collected]);
	print();
	print(self.student_att_resource.berry_collected);
	print(self.student_att_resource.berry_pocket);
	print();
	self.student_att_resource.add_berry_to_pocket();
	SaveLoading.save_to_resource_general(self.student_att_resource, self.save_path);

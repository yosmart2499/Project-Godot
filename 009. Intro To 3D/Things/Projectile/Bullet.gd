extends Area


var speed: int = 15;
var velocity: Vector3 = Vector3();

func start(xform):
	self.transform = xform;
	velocity = - self.transform.basis.z * speed;

func _process(delta):
	transform.origin += velocity * delta;


func _on_Bullet_body_entered(body):
	if(body is StaticBody):
		queue_free();


func _on_Timer_timeout():
	queue_free();

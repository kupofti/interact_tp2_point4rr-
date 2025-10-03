class_name EntityController extends CharacterBody2D

const ACCELERATION = 10;
const MAX_SPEED = 300.0;

var direction = Vector2.ZERO;

func _physics_process(delta: float) -> void:
	if Vector2.ZERO:
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta);
	else:
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta);

	move_and_slide();

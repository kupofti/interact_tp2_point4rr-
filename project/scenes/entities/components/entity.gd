class_name EntityController extends CharacterBody2D

@onready var SPRITE = $AnimatedSprite2D;
var animOverride = false;

const ACCELERATION = 1000.0;
var maxSpeed: float = 100.0;

var direction = Vector2.ZERO;
var heading = false;

func _physics_process(delta: float) -> void:
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * maxSpeed, ACCELERATION * delta);
	else:
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta);

	move_and_slide();

func _process(delta: float) -> void:
	if direction.x != 0: heading = direction.x < 0;
	
	SPRITE.flip_h = heading;

	if !animOverride:
		SPRITE.animation = "idle" if direction.x == 0 else "walk";

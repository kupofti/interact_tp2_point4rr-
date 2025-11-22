class_name Skeleton extends EntityController

@onready var hands = $GrabbyHitbox;

func _process(delta: float) -> void:
	direction = ($"../Player".position - position).normalized();

	super (delta);

	if heading:
		hands.position.x = - abs(hands.position.x);
	else:
		hands.position.x = abs(hands.position.x);

func hurt(hurter, damage):
	print(hurter.is_in_group("enemies"));
	if hurter.is_in_group("enemies"):
		return;

	super (hurter, damage);

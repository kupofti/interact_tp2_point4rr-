extends EntityController

var hasSword = false;
var swinging = false;

func _process(delta: float) -> void:
	direction = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	);
	
	super(delta);

	if hasSword && Input.is_action_pressed("Attack") && !swinging:
		slash();
		
	if swinging:
		SPRITE.animation = "slash";

func slash():
	swinging = true;
	animOverride = true;
	SPRITE.play("slash");

func _end_anim():
	animOverride = false;
	swinging = false;

extends EntityController;

@onready var swordHit = $SwordHitbox;

var hasSword := false;
var swinging := false;

func _process(delta: float) -> void:
	direction = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	);

	super (delta);

	if heading:
		swordHit.position.x = -abs(swordHit.position.x);
	else:
		swordHit.position.x = abs(swordHit.position.x);

	if hasSword and Input.is_action_pressed("Attack") and not swinging:
		slash();


func slash() -> void:
	swinging = true;
	swordHit.hitStart();
	
	play_sequence("slash"); # handles animOverride + audio + auto-reset


func _on_anim_finished() -> void:
	super._on_anim_finished(); # reset animOverride

	swinging = false;
	swordHit.hitStop();

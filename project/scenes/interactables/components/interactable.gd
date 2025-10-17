class_name Interactable
extends Area2D

signal interacted;

@export var uses = 1;
@export var zoom_in = Vector2(4.75, 4.75); # target zoom when near
@export var zoom_out = Vector2(4, 4);      # normal zoom
@export var tween_duration = 0.5 ;          # seconds

var in_area = false;
var player = null;
var camera = null;

func _on_body_entered(body):
	if body.name == "Player":
		in_area = true;
		player = body;
		camera = player.get_node_or_null("Camera2D");
		if camera:
			var tween = create_tween();
			tween.tween_property(camera, "zoom", zoom_in, tween_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT);

func _on_body_exited(body):
	if body.name == "Player":
		in_area = false;
		if camera:
			var tween = create_tween();
			tween.tween_property(camera, "zoom", zoom_out, tween_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT);
		player = null;
		camera = null;

func interact(player):
	uses -= 1;
	emit_signal("interacted");

func _process(delta):
	if in_area and Input.is_action_just_pressed("Interact") and uses > 0:
		interact(player);

class_name EntityController extends CharacterBody2D;

@onready var SPRITE: AnimatedSprite2D = $AnimatedSprite2D;
@onready var AUDIO: AudioStreamPlayer2D = $AudioStreamPlayer2D;

@export var maxHealth := 1.0;
@onready var health := maxHealth;

@export var ACCELERATION := 1000.0;
@export var maxSpeed := 100.0;

var direction := Vector2.ZERO;
var heading := false;
var animOverride := false;

@export var animSounds: Dictionary = {
	"idle": {"stream": null, "loop": false},
	"walk": {"stream": preload("res://assets/audio/walk_hover.wav"), "loop": true},
	"slash": {"stream": preload("res://assets/audio/slash.wav"), "loop": false},
}

var current_anim := "";

func _ready() -> void:
	if SPRITE:
		SPRITE.animation_changed.connect(_on_anim_started);
		SPRITE.animation_finished.connect(_on_anim_finished);
		SPRITE.animation_looped.connect(_on_anim_looped);

func _physics_process(delta: float) -> void:
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * maxSpeed, ACCELERATION * delta);
	else:
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta);
	move_and_slide();


func _process(_delta: float) -> void:
	if direction.x != 0:
		heading = direction.x < 0;
	SPRITE.flip_h = heading;

	if not animOverride:
		var new_anim := "idle" if direction == Vector2.ZERO else "walk";
		if new_anim != current_anim:
			_set_animation(new_anim);

# 
# Stats system
#

func hurt(hurter, damage):
	print(health, " ", damage);
	health -= damage;

	if health <= 0.0:
		die();

	# Knockback
	velocity = (position - hurter.position) * 6;

	$HealthBar.emit_signal("update_health", health / maxHealth * 100);

func die():
	queue_free();

func _on_hurtbox_hit(hurter, damage) -> void:
	if hurter != self:
		hurt(hurter, damage);

#
# Animation sequence system
#

func _set_animation(anim_name: String) -> void:
	current_anim = anim_name;
	SPRITE.play(anim_name);
	_play_animation_sound(anim_name);

# plays an animation that overrides normal updates
func play_sequence(anim_name: String, wait_for_finish: bool = true) -> void:
	animOverride = true;
	current_anim = anim_name;
	SPRITE.play(anim_name);
	_play_animation_sound(anim_name);

	if wait_for_finish and not SPRITE.animation_finished.is_connected(_on_anim_finished):
		SPRITE.animation_finished.connect(_on_anim_finished);

#
# Audio management
#

func _on_anim_started() -> void:
	# Called automatically whenever an animation starts
	_play_animation_sound(SPRITE.animation);


func _play_animation_sound(anim_name: String) -> void:
	if not AUDIO or not animSounds.has(anim_name):
		return ;
	
	var data = animSounds[anim_name];
	var stream: AudioStream = data.get("stream");
	# var loop : bool = data.get("loop", false)
	
	if stream:
		AUDIO.stream = stream;
		AUDIO.play();
		AUDIO.stream_paused = false;
	else:
		AUDIO.stop();


func _on_anim_finished() -> void:
	if animOverride:
		animOverride = false;
		
func _on_anim_looped():
	_play_animation_sound(current_anim);

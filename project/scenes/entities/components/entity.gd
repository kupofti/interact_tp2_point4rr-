class_name EntityController extends CharacterBody2D

@onready var SPRITE: AnimatedSprite2D = $AnimatedSprite2D
@onready var AUDIO: AudioStreamPlayer2D = $AudioStreamPlayer2D

const ACCELERATION := 1000.0
var maxSpeed: float = 100.0

var direction := Vector2.ZERO
var heading := false
var animOverride := false

var anim_sounds := {
	"walk": preload("res://assets/audio/walk_hover.wav"),
	"slash": preload("res://assets/audio/slash.wav"),
}

var current_anim: String = ""


func _physics_process(delta: float) -> void:
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * maxSpeed, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
	move_and_slide()


func _process(delta: float) -> void:
	if direction.x != 0:
		heading = direction.x < 0
	SPRITE.flip_h = heading

	if not animOverride:
		var new_anim := "idle" if direction.x == 0 else "walk"
		if new_anim != current_anim:
			_set_animation(new_anim)

# Animation System

func _set_animation(anim_name: String) -> void:
	current_anim = anim_name
	SPRITE.play(anim_name)
	_play_animation_sound(anim_name)


# Unified Animation Sequence System

# plays an animation that overrides normal updates
func play_sequence(anim_name: String, wait_for_finish: bool = true) -> void:
	animOverride = true
	current_anim = anim_name
	SPRITE.play(anim_name)
	_play_animation_sound(anim_name)

	if wait_for_finish:
		# Connect temporary callback for animation end
		if not SPRITE.animation_finished.is_connected(_on_anim_finished):
			SPRITE.animation_finished.connect(_on_anim_finished)


func _on_anim_finished() -> void:
	# Only clear override if we were in a special sequence
	if animOverride:
		animOverride = false
		SPRITE.animation_finished.disconnect(_on_anim_finished)


# Audio Management

func _play_animation_sound(anim_name: String) -> void:
	if AUDIO and anim_name in anim_sounds:
		AUDIO.stream = anim_sounds[anim_name]
		AUDIO.play()
	elif AUDIO:
		AUDIO.stop()

extends Area2D;

signal hit;

@export var hitDelay := 0.1;

var touched := false;
var cooldown := 0.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func detect(entity, hitbox):
	if cooldown > 0.0:
		pass ;

	cooldown = hitDelay;
	hit.emit(entity, hitbox.damage);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cooldown > 0:
		cooldown -= delta;

func _physics_process(_delta: float) -> void:
	var areas = get_overlapping_areas();

	for area in areas:
		if area.is_in_group("hitbox"):
			var entity = area.owner;
			detect(entity, area);

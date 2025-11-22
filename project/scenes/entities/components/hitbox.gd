extends Area2D

@onready var shape = $CollisionShape2D;

@export var damage := 0.0;
@export var ontime := INF;
@export var offtime := 0.0;
@export var enabled := false;

var heatup := 0.0;
var cooldown := 0.0;

func _ready():
	shape.disabled = !enabled;

func hitStart():
	if cooldown > 0.0:
		return ;

	enabled = true;
	shape.disabled = false;

func hitStop():
	enabled = false;
	shape.disabled = true;

	heatup = 0.0;
	cooldown = offtime;

func _process(delta: float) -> void:
	if enabled && heatup < ontime:
		heatup += delta;
	
	if heatup > ontime:
		hitStop();

	if cooldown > 0.0:
		cooldown -= delta;

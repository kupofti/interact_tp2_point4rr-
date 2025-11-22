extends Marker2D

@export var spawnScene: PackedScene;
@export var spawns := 1;
@export var spawnDelay := 1.0;
@export var active := false;

var cooldown := 0.0;

func spawn():
	var spawnInstance = spawnScene.instantiate();
	get_tree().current_scene.add_child(spawnInstance);
	spawnInstance.global_position = global_position;

func _process(delta: float) -> void:
	if active:
		if cooldown > 0.0:
			cooldown -= delta;
		else:
			spawn();
			cooldown = spawnDelay;
			spawns -= 1;

			if spawns <= 0:
				queue_free();

extends Skeleton

@export var crownScene: PackedScene;

func die():
	var crownDrop = crownScene.instantiate();
	get_tree().current_scene.add_child(crownDrop);
	crownDrop.global_position = global_position;

	super();

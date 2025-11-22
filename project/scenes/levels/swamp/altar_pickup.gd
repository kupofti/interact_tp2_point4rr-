extends Interactable

@onready var spawners := $Spawners.get_children();

func interact(player):
	super(player);
	
	player.maxSpeed = 200.0;
	player.hasSword = true;
	player.slash();

	for spawner in spawners:
		spawner.active = true;

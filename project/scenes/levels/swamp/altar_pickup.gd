extends Interactable


func interact(player):
	super(player);
	
	player.maxSpeed = 200.0;
	player.hasSword = true;
	player.slash();

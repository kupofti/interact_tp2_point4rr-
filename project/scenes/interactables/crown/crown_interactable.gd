extends Interactable;

func interact(player):
	super(player);

	player.play_sequence("doom");
	player.maxHealth += 10;
	player.health = player.maxHealth;
	player.swordHit.damage += player.maxHealth / 80;
	player.hbupdate();

	get_parent().doom(player.maxHealth);

	queue_free();

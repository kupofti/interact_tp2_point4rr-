extends Node2D

func doom(n):
	$DoomSpawner.spawns = n / 40;
	$DoomSpawner.active = true;

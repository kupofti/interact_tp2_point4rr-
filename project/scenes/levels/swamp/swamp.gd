extends Node2D

func doom(n):
	$DoomSpawner.spawns = n / 20;
	$DoomSpawner.active = true;

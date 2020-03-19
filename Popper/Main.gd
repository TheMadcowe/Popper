extends Node


onready var player = load("res://Player.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():

	var player_instance = player.instance()
	player_instance.set_name("Player")
	add_child(player_instance)
	

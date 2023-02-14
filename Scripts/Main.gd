extends Node


onready var player = load("res://Player/Player.tscn")

onready var playerPosition = $Player_Spawn
# Called when the node enters the scene tree for the first time.


func _ready():

	var player_instance = player.instance()
	player_instance.set_name("Player")
	add_child(player_instance)
	player_instance.position = playerPosition.position
	
	$Player/HUD/Text.visible = false

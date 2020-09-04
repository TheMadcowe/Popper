extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



onready var Map = $TileMap
var width = 40
var height = 40
var cell_width = 8

# 0 = grass, 1 = gold, 2 = iron, 3 = silver, 4 = copper, 5 = sapphire, 6 = dirt

# Called when the node enters the scene tree for the first time.
func _ready():
	for n in width:
		for y in height:
				Map.set_cellv(Vector2(n,y), 6)
	
	add_Minerals()
	add_Grass()
	pass # Replace with function body.

func add_Minerals():
	for n in width:
		for y in height:
			var percent = randi() % 20
			if percent > 15:
				var mineral = randi() % 4 +1
				Map.set_cellv(Vector2(n,y), mineral)

func add_Grass():
	for n in width:
		Map.set_cellv(Vector2(n,0), 0)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

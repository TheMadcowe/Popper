extends Node

@onready var objects = $Objects
@onready var player_position = $Player_Spawn

@export var winHeight = -300
@export var loseHeight = 300

var hud_scene = preload("res://Player/HUD.tscn")
var hud: CanvasLayer
var player: Player

var finished = false

func _ready():
	hud = hud_scene.instantiate()
	add_child(hud)

	player = preload("res://Player/Player.tscn").instantiate()
	player.position = player_position.position
	add_child(player)
	
	# Connect player signals
	player.connect("balloon_hit", Callable(Game, "_on_balloon_hit")) # Example if you want boost to count?
	player.connect("coin_collected", Callable(Game, "_on_coin_collected"))
	player.connect("combo_incremented", Callable(hud, "_on_combo_incremented"))
	player.connect("reached_win", Callable(self, "_on_level_won"))
	player.connect("reached_lose", Callable(self, "_on_level_lose"))
	
	
	_add_objects()


func _physics_process(_delta):
	
	if finished or not player:
		return
		
	if player.position.y < winHeight:
		_on_player_win()

	elif player.position.y > loseHeight:
		_on_player_lose()

		
func _on_player_win():
		finished = true
		Game.emit_signal("level_completed")
		hud.youWin()
		
func _on_player_lose():
		finished = true
		Game.emit_signal("level_failed")
		get_tree().change_scene_to_file("res://Stages/Main.tscn")
	
func _input(event):
	
	if finished:
		if event.is_action_pressed("jump") or event.is_action_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://Stages/Main.tscn")

			

func _add_objects():
	var usedCells = objects.get_used_cells()
	var total_hp = 0
	
	#Map tile IDs to text keys (used for tilemap -> Game.OBJECTS)
	var id_to_key = {
		0: "balloon",
		1: "coin",
		3: "smile",
		4: "big_balloon"
	}
	
	for cell in usedCells:
		var tile_id = objects.get_cell_source_id(cell)
		if not id_to_key.has(tile_id):
			continue
		
		var key = id_to_key[tile_id]
		var data = Game.OBJECTS[key]
		var instance = data["scene"].instantiate()
		add_child(instance)
		instance.add_to_group(data["group"])
		instance.position = objects.map_to_local(cell)
		
		if data["group"] == "Balloons" and  "hp" in instance:
			total_hp += instance.hp
		
	objects.clear()
	Game.reset_level_balloon_hp(total_hp)
	print(total_hp)
	Game.emit_signal("balloon_popped", 0)

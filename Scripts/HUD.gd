extends CanvasLayer

@onready var comboText = $Text/ComboText
@onready var remainingText = $Text/RemainingText
@onready var coinsText = $Text/CoinsText
@onready var finishText = $Text/FinishText

var _timer = Timer.new()


func _ready():

	add_child(_timer)
	_timer.connect("timeout", Callable(self, "hideCombo"))
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false) # Make sure it loops
	
	Game.connect("balloon_popped", Callable(self, "_on_balloon_popped"))
	Game.connect("coin_collected", Callable(self, "_on_coin_collected"))
	
	updateRemaining(Game.total_balloon_hp)
	updateCoins(Game.total_coins)
	

func _on_balloon_popped(_damage):
	updateRemaining(Game.total_balloon_hp)
	
func _on_coin_collected(_amount):
	updateCoins(Game.total_coins)

func updateRemaining(remaining):
	if remaining > 0:
		remainingText.text = "Remaining: %s" % [remaining]
	else:
		remainingText.text = "ALL POPT!"

func updateCoins(coins):
	coinsText.text = "Coins: %s" % [coins]

# Called when the node enters the scene tree for the first time.
func updateCombo(combo):
	if(combo > 0):
		_timer.stop()
		comboText.visible = true
		comboText.add_theme_color_override("font_color", Color(1,1,1,1))
		comboText.text = "Combo: %sx" % [combo]
	else:
		comboText.add_theme_color_override("font_color", Color(1,0,0,1))
		_timer.start()

func hideCombo():
	comboText.visible = false

#	comboText.margin_bottom = (randi() % 100)
#	comboText.margin_left = (randi() % 100)
#	comboText.margin_top = (randi() % 100)
#	comboText.margin_right = (randi() % 100)

	pass # Replace with function body.

func youWin():
	remainingText.visible = false
	coinsText.visible = false
	comboText.visible = false
	finishText.visible = true

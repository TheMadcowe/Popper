extends CanvasLayer

onready var comboText = $Text/ComboText
onready var remainingText = $Text/RemainingText
onready var coinsText = $Text/CoinsText
onready var finishText = $Text/FinishText

var _timer = Timer.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():

	add_child(_timer)
	_timer.connect("timeout", self, "hideCombo")
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false) # Make sure it loops


# Called when the node enters the scene tree for the first time.
func updateCombo(combo):
	print(combo)
	if(combo > 0):
		_timer.stop()
		comboText.visible = true
		comboText.add_color_override("font_color", Color(1,1,1,1))
		comboText.text = "Combo: %sx" % [combo]
	else:

		

		comboText.add_color_override("font_color", Color(1,0,0,1))
		_timer.start()

func hideCombo():
	comboText.visible = false

#	comboText.margin_bottom = (randi() % 100)
#	comboText.margin_left = (randi() % 100)
#	comboText.margin_top = (randi() % 100)
#	comboText.margin_right = (randi() % 100)

	pass # Replace with function body.
	
func updateRemaining(remaining):
	if remaining > 0:
		remainingText.text = "Remaining: %s" % [remaining]
	else:
		remainingText.text = "ALL POPT!"

func updateCoins(coins):
	coinsText.text = "Coins: %s" % [coins]
	pass;
	

func youWin():
	remainingText.visible = false
	coinsText.visible = false
	comboText.visible = false
	
	finishText.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

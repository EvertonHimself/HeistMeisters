extends CanvasModulate

const DARK = Color("141514")
const NIGHTVISION = Color("38f255")

var cooldown = false

func _ready():
	color = DARK
	
func cycle_vision_mode():
	if not cooldown:
		if color == NIGHTVISION:
			DARK_Mode()
		else:
			NIGHTVISION_Mode()
		cooldown = true
		$Timer.start()

func DARK_Mode():
	color = DARK
	$AudioStreamPlayer2D.stream = load("res://SFX/nightvision_off.wav")
	$AudioStreamPlayer2D.play()
	get_tree().call_group("Lights", "show")
	get_tree().call_group("Labels", "hide")

func NIGHTVISION_Mode():
	color = NIGHTVISION
	$AudioStreamPlayer2D.stream = load("res://SFX/nightvision.wav")
	$AudioStreamPlayer2D.play()
	get_tree().call_group("Lights", "hide")
	get_tree().call_group("Labels", "show")


func _on_Timer_timeout():
	cooldown = false

extends "res://Characters/TemplateCharacter.gd"

var motion = Vector2()

const PLAYER_SPRITE = "res://GFX/PNG/Hitman 1/hitman1_stand.png"
const BOX_SPRITE = "res://GFX/PNG/Tiles/tile_130.png"
const PLAYER_OCCLUDER = "res://Characters/HumanOccluder.tres"
const BOX_OCCLUDER = "res://Characters/BoxOccluder.tres"
const PLAYER_LIGHT = "res://GFX/PNG/Hitman 1/hitman1_stand.png"
const BOX_LIGHT = "res://GFX/PNG/Tiles/tile_130.png"

var disguised = false

func _physics_process(delta):
	update_movement()
	move_and_slide(motion)
	
func update_movement():
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("move_down") and not Input.is_action_just_pressed("move_up"):
		motion.y = clamp(motion.y + SPEED, 0, MAX_SPEED)
	elif Input.is_action_pressed("move_up") and not Input.is_action_just_pressed("move_down"):
		motion.y = clamp(motion.y - SPEED, -MAX_SPEED, 0)
	else:
		motion.y = lerp(motion.y, 0, FRICTION)
	
	if Input.is_action_pressed("move_left") and not Input.is_action_just_pressed("move_right"):
		motion.x = clamp(motion.x - SPEED, -MAX_SPEED, 0)
	elif Input.is_action_pressed("move_right") and not Input.is_action_just_pressed("move_left"):
		motion.x = clamp(motion.x + SPEED, 0, MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)

#func _input(event):
	#if Input.is_action_just_pressed("flashlight"):
		#$Torch.enabled = !$Torch.enabled

func _input(event):
	if Input.is_action_just_pressed("flashlight"):
		get_tree().call_group("Interface", "cycle_vision_mode")
	# Toggle the box.
	if Input.is_action_justpressed("toggle_disguise"):
		toggle_disguise()

func toggle_disguise():
	if disguised:
		reveal()
	else:
		disguise()

func reveal():
	$Sprite.texture = load(PLAYER_SPRITE)
	$LightOccluder2D.occluder = load(PLAYER_OCCLUDER)
	$Light2D.texture = load(PLAYER_LIGHT)
	disguised = false
	collision_layer = 16

func disguise():
	$Sprite.texture = load(BOX_SPRITE)
	$LightOccluder2D.occluder = load(BOX_OCCLUDER)
	$Light2D.texture = load(BOX_LIGHT)
	disguised = false
	collision_layer = 1

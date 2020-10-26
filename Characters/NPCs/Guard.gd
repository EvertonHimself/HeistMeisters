extends "res://Characters/NPCs/PlayerDetection.gd"

onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
onready var destinations = navigation.get_node("Destinations")

var motion
var possible_destinations
var path

export var minimum_arrival_distance = 5
export var walk_speed = 0.5

func _ready():
	randomize()
	possible_destinations = destinations.get_children()
	make_path()

func make_path():
	var new_destination = possible_destinations[randi() % possible_destinations.size() - 1]
	path = navigation.get_simple_path(position, new_destination.position)
	
func _physics_process(delta):
	navigate()

func navigate():
	var distance_to_destination = position.distance_to(path[0])
	if distance_to_destination > minimum_arrival_distance:
		move()
	else:
		update_path()

func move():
	pass

func update_path():
	if path.size() == 1 and $Timer.is_stopped():
		$Timer.start()
	else:
		path.pop_front()

func _on_Timer_timeout():
	pass # Replace with function body.
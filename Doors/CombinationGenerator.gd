extends Node

func generate_combination(length):
	var combination = []
	for number in range(length):
		# Generate random numbers between 0 and 10.
		combination.append(randi() % 10)
	return combination

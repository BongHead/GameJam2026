extends Node
# Singleton Service for dice rolls
var RNG = RandomNumberGenerator.new()

func rollOneD6() -> int:
	return RNG.randi_range(1, 6)
	
func rollTwoD6() -> int:
	return RNG.randi_range(1, 6) + RNG.randi_range(1, 6)

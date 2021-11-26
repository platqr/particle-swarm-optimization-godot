extends Sprite

var setMinMax = 0

const EXP = 2.718281828459045

var velocity = Vector2(0,0)
var fitness
var bestFit
var bestPos

var globalBestFitLoc

export var w = 1
export var d = 0.98
export var c1 = 2
export var c2 = 2

func _ready():
	randomize()
	position = Vector2(rand_range(72,738), rand_range(72, 738))
	fitness = objective_function(convertToDat(position))
	bestFit = fitness
	bestPos = convertToDat(position)
	
func move(glB):
	velocity = (w*velocity) + (c1*(bestPos-convertToDat(position))) + (c2*(glB-convertToDat(position)))
	position = position + velocity
	w = w*d
	fitness = objective_function(convertToDat(position))
	if(setMinMax == 0):
		if fitness > bestFit:
			bestPos = convertToDat(position)
			bestFit = fitness
			if bestFit > globalBestFitLoc:
				globalBestFitLoc = bestFit
	elif(setMinMax == 1):
		if fitness < bestFit:
			bestPos = convertToDat(position)
			bestFit = fitness
			if bestFit < globalBestFitLoc:
				globalBestFitLoc = bestFit

func objective_function(o):
	var x = o.x
	var y = o.y
	#DROP-WAVE FUNCTION
	var z = -((1+cos(12*sqrt((x*x)+(y*y))))/(0.5*((x*x)+(y*y))+2))
	return z

func convertToDat(vec):
	var newVec = Vector2(((vec.x - 405) * 20 / 666),((vec.y - 405) * 20 / 666))
	return newVec

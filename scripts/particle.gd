extends Sprite

var setMinMax = 0

const EXP = 2.718281828459045

var velocity = Vector2(0,0)
var fitness
var bestFit
var bestPos

var globalBestFitLoc  = 0

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
	var z = 3 * pow((1-x),2) * pow(EXP,(-pow(x,2) - pow((y+1),2))) - 10 * (x/5 - pow(x,3) - pow(y,5)) * pow(EXP,(-pow(x,2) - pow(y,2))) - 1/3 * pow(EXP,(-(pow((x+1),2)) - pow(y,2)))
	return z

func convertToDat(vec):
	var newVec = Vector2(((vec.x - 405) * 20 / 666),((vec.y - 405) * 20 / 666))
	return newVec

func setMinMaxTo(r):
	setMinMax = r

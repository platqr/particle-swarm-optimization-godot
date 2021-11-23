extends Node2D

#particle scene preload
var particle = preload("res://scenes/particles/particle3.tscn") #preload particle scene
var particleInstance = [] #particle array

var pop = 50 #population
var globalBestFit = -999999 #best global fitness
var globalBestPos = Vector2(0,0) #best global position

var isRunning = false
var functionIndex
var minMax = 0

func _ready():
	for n in pop:
		createNewParticle(n)
	$Control/PopInput.text = str(pop)

func createNewParticle(n):
	particleInstance.push_back(particle.instance())
	add_child(particleInstance[n])

func getGlobalBest():#called on timer
	for n in particleInstance.size():
		if(minMax == 0):
			if particleInstance[n].globalBestFitLoc > globalBestFit:
				globalBestFit = particleInstance[n].globalBestFitLoc
				globalBestPos = particleInstance[n].bestPos
		elif(minMax == 1):
			if particleInstance[n].globalBestFitLoc < globalBestFit:
				globalBestFit = particleInstance[n].globalBestFitLoc
				globalBestPos = particleInstance[n].bestPos

func setNewPop():#in set button
	for n in particleInstance.size():
		particleInstance[n].queue_free()
	particleInstance.clear()
	pop = int($Control/PopInput.text)
	for n in pop:
		createNewParticle(n)

func _on_Timer_timeout():
	getGlobalBest()
	get_tree().call_group("particles", "move", globalBestPos)
	$Control/FitLabel.text = "Best Fitness: " + str(globalBestFit)

func _on_Start_button_down():
	if (!isRunning):
		$Timer.start()
		isRunning = !isRunning
		$Control/Start.text = "Stop"
	else:
		$Timer.stop()
		isRunning = !isRunning
		$Control/Start.text = "Continue"

func _on_Set_button_down():
	$Timer.stop()
	setNewPop()
	isRunning = false
	$Control/Start.text = "Start"
	$Control/FitLabel.text = "Best Fitness: 000.000"
	
	get_tree().call_group("particles", "setMinMaxTo", $Control/minManCh.get_selected_id())
	if($Control/minManCh.get_selected_id() == 0):
		globalBestFit = -999999
		minMax = 0
	elif($Control/minManCh.get_selected_id() == 1):
		globalBestFit = 999999
		minMax = 1

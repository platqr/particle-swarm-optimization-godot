extends Node2D

#particle scene preload
var particle1 = preload("res://scenes/particles/particle1.tscn") #preload particle scene
var particle2 = preload("res://scenes/particles/particle2.tscn") #preload particle scene
var particle3 = preload("res://scenes/particles/particle3.tscn") #preload particle scene
var particle4 = preload("res://scenes/particles/particle4.tscn") #preload particle scene
var particle5 = preload("res://scenes/particles/particle5.tscn") #preload particle scene
var particle6 = preload("res://scenes/particles/particle6.tscn") #preload particle scene
var particle7 = preload("res://scenes/particles/particle7.tscn") #preload particle scene
var particle8 = preload("res://scenes/particles/particle8.tscn") #preload particle scene
var particle9 = preload("res://scenes/particles/particle9.tscn") #preload particle scene
var particle10 = preload("res://scenes/particles/particle10.tscn") #preload particle scene

var particleInstance = [] #particle array

var pop = 50 #population
var globalBestFit = -999999 #best global fitness
var globalBestPos = Vector2(0,0) #best global position

var isRunning = false
var functionIndex
var minMax = 0
var funcT = 0

func _ready():
	for n in pop:
		createNewParticle(n)
	$Control/PopInput.text = str(pop)

func createNewParticle(n):#in ready & setNewPop
	chooseFunc()
	add_child(particleInstance[n])
	particleInstance[n].setMinMax = $Control/minManCh.get_selected_id()
	particleInstance[n].globalBestFitLoc = globalBestFit

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
	funcT = $Control/funcChoose.get_selected_id()
	for n in pop:
		createNewParticle(n)

func setNewGlBest():#in set button
	if($Control/minManCh.get_selected_id() == 0):
		globalBestFit = -999999
		minMax = 0
	elif($Control/minManCh.get_selected_id() == 1):
		globalBestFit = 999999
		minMax = 1

func chooseFunc():
	if(funcT == 0): particleInstance.push_back(particle1.instance())
	elif(funcT == 1): particleInstance.push_back(particle2.instance())
	elif(funcT == 2): particleInstance.push_back(particle3.instance())
	elif(funcT == 3): particleInstance.push_back(particle4.instance())
	elif(funcT == 4): particleInstance.push_back(particle5.instance())
	elif(funcT == 5): particleInstance.push_back(particle6.instance())
	elif(funcT == 6): particleInstance.push_back(particle7.instance())
	elif(funcT == 7): particleInstance.push_back(particle8.instance())
	elif(funcT == 8): particleInstance.push_back(particle9.instance())
	elif(funcT == 9): particleInstance.push_back(particle10.instance())

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
	isRunning = false
	setNewGlBest()
	setNewPop()
	$Control/Start.text = "Start"
	$Control/FitLabel.text = "Best Fitness: 000.000"

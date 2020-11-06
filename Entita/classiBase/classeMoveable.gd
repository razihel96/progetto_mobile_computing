extends KinematicBody

class_name Moveable

#variabili di movimento
#sovrascriverli da stats spd e stats ag per combattente?
var spd = 600	#velmax
var curspd = 0
var accel = 4000		#velore aggiungibile da accel in un secondo

var friction = 3000 # decelerazione da fermo

var scalare = 1

var targetDir = Vector3()
var hordir = Vector2(0,0)
var vel = Vector3()

var gravity = Vector3.DOWN * 300
var jump = false

#gestione stati
var stato = 0
const Idle = 0
const Moving = 1

#nodo che contiene nodi interessati alla rotazione, es: mesh instance
onready var rotable = get_node("rotable")

func setTargetDir(newtarget : Vector3):
	if newtarget != Vector3(0,0,0):
		targetDir = newtarget.normalized()
		if stato == Idle or stato == Moving:
			stato = Moving
	else:
		targetDir = Vector3()
		if stato == Idle or stato == Moving:
			stato = Idle

#scalo valori in base a velocità, delta ecc... e li metto in velocity
func applyDir(delta):
	#curspd = clamp(curspd + accel *delta, 0, spd)
	hordir.x = clamp(hordir.x + targetDir.x * accel * delta,-spd,spd)
	hordir.y = clamp(hordir.y + targetDir.z * accel * delta,-spd,spd)
	hordir = hordir.clamped(600)
	curspd= hordir.length()
	
func guardaVerso(dir : Vector3):
	var angle = atan2(dir.x,dir.z)
	var char_rot = rotable.get_rotation()
	char_rot.y = angle
	rotable.set_rotation(char_rot)

#per ora non ha l'under_ score per non confoderla con il physics process di sistema
#sennò godot invece di sovrascrivere la esegue due volte per ogni nodo che eredita combattente
#da verificare se anche le altre funzioni sovrascritte hanno effetto simile, ma non pare
func physics_process(delta):
	curspd = max (curspd - friction*delta, 0)
	hordir = hordir.clamped(curspd)
	if not is_on_floor():
		vel += gravity * delta
		
	if stato == Moving:
		applyDir(delta)
		guardaVerso(targetDir)
		
	var dir = hordir * delta * scalare
	vel.x = dir.x
	vel.z = dir.y
	move_and_slide(vel, Vector3.UP,true,4,0.3)

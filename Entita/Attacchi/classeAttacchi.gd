extends Area

class_name Attacco

const Fisico = 0
const Fuoco = 1
const Ghiaccio = 2
const Elettro = 3
const Acqua = 4

var danno : int = 0
var element : int = 0

var malusRate = 0
var mpCost : int = 0
var timeout : float = 1
var target = "enemy"

var audio 

func iniziaStats(ndanno,nelement,costo,ntimeout):
	danno = ndanno
	element = nelement
	mpCost = costo
	timeout = ntimeout

#distrugge l'attacco dopo un po' dalla sua creazione
func _process(delta):
	if(timeout<0):
		self.queue_free()
	else:
		timeout -= delta

func setSpd(_spd):
	pass

func perAtk(_atk):
	pass

#cosa fare quando attacco colpisce qualcosa
func hit(body):
	if(body.is_in_group(target)):
		body.hit(danno,element,malusRate)
	pass 
	

extends Combattente

var scattando = 1
var inputDir = Vector2()

var coins = 0
var items = 0


var attaccoBase = preload("../Attacchi/fisico/SwordSlash.tscn")
var fuoco = preload("../Attacchi/Speciali/fuoco/lanciafiamme.tscn")
var ghiaccio = preload("res://Entita/Attacchi/Speciali/ghiaccio/VentoGhiacciato.tscn")
var tuono = preload("res://Entita/Attacchi/Speciali/elettro/Tuono.tscn")
var bolla = preload("res://Entita/Attacchi/Speciali/acqua/Bollaraggio.tscn")

var target = "enemy"

onready var anim = $rotable/mesh/AnimationPlayer
onready var cam = $rotable/Camera
onready var stick = $rotable/Camera/UI/CombatUI/movStick
onready var scattoTimer = $Timer/scatto
onready var healthBar = $rotable/Camera/UI/CombatUI/healthBar
onready var mpBar = $rotable/Camera/UI/CombatUI/mpBar
onready var dodgeBar = $rotable/Camera/UI/CombatUI/gameButtons/scatto/ProgressBar
onready var UI = get_node("rotable/Camera/UI") #nasconde l'UI durante la scena "PASSAGGIO"

onready var screenSize = OS.get_window_size()

func _ready():
	knownSpecials = [fuoco,ghiaccio, tuono, bolla]
	scattoTimer.stop()
	sceneUtili.player = self

var stickidx = -1
#prende input per il movimento dal tocco
func _input(event):
	if event is InputEventScreenTouch and event.is_pressed() and event.position.x < screenSize.x/2:
		stick.position = event.position
		stick.show()
		stickidx = event.index
	if(event is InputEventScreenTouch and not event.is_pressed() and event.index == stickidx):
		stick.hide()
		inputDir  = Vector2(0,0)
		stickidx = -1
		setTargetDir(Vector3(inputDir.x,0,inputDir.y))
	if(event is InputEventScreenDrag and event.index == stickidx):
		inputDir = stick.position - event.position
		var movDir = get_viewport().get_camera().global_transform.basis.z.rotated(Vector3.UP, inputDir.angle_to(Vector2.UP))
		setTargetDir(Vector3(movDir.x,0,movDir.z))
		
#input ma dal pc
func input_pc():
	inputDir = Vector2(0,0)
	if( Input.is_action_pressed("sinistra")):
		inputDir.x+= 1
	elif(Input.is_action_pressed("destra")):
		inputDir.x += -1
	if(Input.is_action_pressed("su")):
		inputDir.y += 1
	elif(Input.is_action_pressed("giu")):
		inputDir.y += -1
	setTargetDir(Vector3(inputDir.x,0,inputDir.y))
	
	if Input.is_action_just_pressed("attacco"):
		attaccaChecked(attaccoBase,false)
	if Input.is_action_just_pressed("scatta"):
		scatta()

#aggiorna animazioni, scatto e barra magia e richiama la "farlocca"
#physics_process della classe madre
func _physics_process(delta):
	mpBar.value = (float(mp) /stats.maxmp) *100
	
	if( not scattoTimer.is_stopped()):
		dodgeBar.value = (1.5 - scattoTimer.time_left) / 1.5 * 100
	
	scattando = max( 1 , scattando- delta*10)
	if(scattando<=1):
		scattando = 1
	else:
		scattando -= delta *10
	scalare = scattando
	#input_pc()
	.physics_process(delta)
	if stato == Moving:
		anim.play("sword and shield run-loop")
	elif stato == Idle:
		anim.play("sword and shield idle-loop")

#piccolo wrap per gli attacchi con animazioni e controllo che non si stia gi?? attaccando
func attaccaChecked(attacco,isSpecial):
	if (stato != Attacking and stato != Dead and combo == 0):
		.attacca(attacco,target)
		if isSpecial:
			anim.play("sword and shield casting 2-loop")
		else:
			if(stato == Attacking):
				anim.play("sword and shield slash-loop")
				anim.advance(0.5)
				combo+=1
	if(combo >0 and stato!= Dead):
		if(attackTimeout >0 and attackTimeout <0.2):
			match combo:
				1:
					anim.play("sword and shield slash 3-loop")
					.attacca(attacco,target)
					anim.advance(0.5)
					combo += 1
				2:
					anim.play("sword and shield attack 2-loop")
					var attackDir = (spawnAtk.global_transform.origin - self.global_transform.origin).normalized()
					attackDir.y = 0
					setForce(attackDir, 500, 0.5)
					.attacca(attacco,target)
					combo = 0

#scattando e uno scalare della velocita che diminuisce di 1 al secondo
#il timer tiene conto di quando poter riscattare
func scatta():
	if (scattando <= 1 and scattoTimer.is_stopped()):
		scattando = 4;
		scattoTimer.start()
		dodgeBar.value = 0
		

func hit(danno, elemento,malusRate):
	.hit(danno, elemento,malusRate)
	healthBar.value = (float(hp)/stats.maxhp) * 100

func muori():
	if(stato != Dead):
		anim.play("sword and shield death-loop")
		anim.get_animation("sword and shield death-loop").loop = false
	stato = Dead

func _on_scatto_timeout():
	scattoTimer.stop()
	dodgeBar.value = 100
	pass # Replace with function body.

func convertStringa():
	$rotable/Camera/UI/UIcoins_item/counterCoins.text = String(coins)
	$rotable/Camera/UI/UIcoins_item/counterItems.text = String(items)


#CONTATORE MONETE
func collectCoin():
	coins = coins + 1
	convertStringa()

#CONTATORE OGGETTI
func collectItem():
	items = items + 1
	convertStringa()

func collectCoinEnemy():
	coins = coins + 5
	convertStringa()

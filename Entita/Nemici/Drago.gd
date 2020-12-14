extends Nemico

var fuoco = load("res://Entita/Attacchi/Speciali/fuoco/lanciafiamme.tscn")


func _ready():
	self.iniziaStats(1.5,100,20,100,350)
	attacco = load("res://Entita/Attacchi/fisico/SwordSlash.tscn")
	anim = get_node("rotable/mesh/AnimationPlayer")
	get_parent().contaNemici += 1
	print("nasce drago: ", get_parent().contaNemici)

func _physics_process(delta):
	.physics_process(delta)
	if stato == Moving:
		anim.play("DragonArmature|Dragon_Flying")

func muori():
	.muori()
	get_parent().contaNemici -= 1
	print("muore drago: ", get_parent().contaNemici)
	anim.play("DragonArmature|Dragon_Death")


func _on_Area_body_entered(body):
	if(not morto and stunned <=1):
		if(body.is_in_group(target)):
			if(mp > 30):
				attacca(fuoco,target)
			else:
				attacca(attacco,target)
			anim.play("DragonArmature|Dragon_Attack2")

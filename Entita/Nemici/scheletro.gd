extends Nemico


func _ready():
	attacco = load("res://Entita/Attacchi/fisico/SwordSlash.tscn")
	self.iniziaStats(1.5,1,20,1,300)
	anim = get_node("rotable/mesh/AnimationPlayer")
	get_parent().contaNemici += 1
	print("nasce scheletro: ", get_parent().contaNemici)



func _physics_process(delta):
		.physics_process(delta)
		if (stato == Moving ):
			anim.play("SkeletonArmature|Skeleton_Running")



func muori():
	.muori()
	get_parent().contaNemici -=1
	print("muore scheletro: ", get_parent().contaNemici)
	anim.play("SkeletonArmature|Skeleton_Death")



func _on_Area_body_entered(body):
	if(not morto and stunned <=1 and not force):
		if(body.is_in_group(target)):
			attacca(attacco,target)
			anim.play("SkeletonArmature|Skeleton_Attack")

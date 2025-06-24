extends Area2D

class_name BaseDrone

@export var speed = 350
@export var steer_force = 150.0

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null

func _on_body_entered(body: Node2D) -> void:
	if body is BaseAmmo:
		body.queue_free()
		explode()
	if body is BaseShotgun:
		explode()

func start(_transform, _target):
	global_transform = _transform
	rotation += randf_range(-0.09, 0.09)
	velocity = transform.x * speed
	target = _target

func seek():
	var steer = Vector2.ZERO
	if target:
		var desired = ((target.position - position).normalized() + Vector2(randf_range(-3.0, 3.0), randf_range(-3.0, 3.0))) * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

func _physics_process(delta):
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.limit_length(speed)
	rotation = velocity.angle()
	position += velocity * delta

func explode():
	set_physics_process(false)
	damage()
	$AnimationPlayer.play("explosion")
	$AnimationPlayer.animation_finished.connect(func(anim_name: StringName):queue_free())

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area is BaseGround:
		explode()
		
func damage():
	for body in $explosive.get_overlapping_bodies():
		if body is BaseShotgun:
			body.damage()

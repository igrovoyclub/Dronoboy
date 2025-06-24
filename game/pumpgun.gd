extends CharacterBody2D

class_name BaseShotgun

@export var speed:int = 500
@export var parent_scene:Node2D = null
var p_bulet = preload("res://game/ammo.tscn")

func _process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		velocity = Vector2(-speed, 0)
		
	if event.is_action_pressed("ui_right"):
		velocity = Vector2(speed, 0)
		
	if event.is_action_released("ui_left") or event.is_action_released("ui_right"):
		velocity = Vector2.ZERO
		
	if event.is_action_pressed("ui_up"):
		if parent_scene:
			var ammo = p_bulet.instantiate()
			parent_scene.add_child(ammo)
			ammo.global_position = $mazzle.global_position
			shot()
			
func shot():
	$AnimationPlayer.play("shot")
	
func damage():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("pumpgun_blink")

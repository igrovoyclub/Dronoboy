extends Node2D

var p_drone = preload("res://game/dron.tscn")
var drone_instance:BaseDrone = null
@export var shotgun:BaseShotgun = null

func spawn():
	drone_instance = p_drone.instantiate()
	get_parent().add_child(drone_instance)
	drone_instance.start(global_transform, shotgun)
	
func _on_timer_timeout() -> void:
	spawn()

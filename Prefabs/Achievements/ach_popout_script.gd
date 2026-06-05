extends Control

var move_in : bool
var move_out : bool
var start_pos : float


func popout() -> void:
	$Timer.start(3)


func _on_timer_timeout() -> void:
	queue_free()

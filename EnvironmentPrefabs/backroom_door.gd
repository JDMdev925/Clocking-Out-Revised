extends MeshInstance3D

@onready var dirLock = $"../../../../../PuzzleItems/DirectionalLock"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MainManager.connect("lock_complete", Callable(self, "updatePos"))
	

func updatePos():
	dirLock.reparent(self)
	global_position.x = 4.5
	global_position.z = 4.8
	rotation = Vector3.ZERO

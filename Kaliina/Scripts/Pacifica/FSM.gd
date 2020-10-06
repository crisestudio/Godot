extends Spatial

onready var current = $"IDLE"
onready var direction = Vector2.DOWN
onready var old_direction = Vector2.DOWN
onready var Root = $"../"

func _process(delta):
	current.Update(delta)
	
func _physics_process(delta):
	current.Physics(delta)
	
func ChangeState(STATE):
	match (STATE):
		"IDLE" : current = $IDLE
		"WALK" :  current = $WALK

func Rotate_Angle(dir):
	match (dir):
		Vector2(0, 1): Root.rotation_degrees = Vector3.ZERO
		Vector2(-1, 0): Root.rotation_degrees = Vector3(0, 90, 0)
		Vector2(1, 0): Root.rotation_degrees = Vector3(0, -90, 0)
		Vector2(0, -1): Root.rotation_degrees = Vector3(0, 180, 0)
		Vector2(1, 1): Root.rotation_degrees = Vector3(0, -45, 0)
		Vector2(-1, 1): Root.rotation_degrees = Vector3(0, 45, 0)
		Vector2(-1, -1): Root.rotation_degrees = Vector3(0, 145, 0)
		Vector2(1, -1): Root.rotation_degrees = Vector3(0, -145, 0)

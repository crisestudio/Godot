extends KinematicBody2D

var id
var pos
var direction = 5
onready var speed = rand_range(0.5, 4)
var wait = false

func _process(delta):
	if !wait:
		Move($"../../Scripts/Variables".Player.pos, $"../../Scripts/Map".Map, $"../../Scripts/Map".mapsize)
	
		match(direction):
			4 : move_and_collide(Vector2(-speed, 0))
			6 : move_and_collide(Vector2(speed, 0))
			8 : move_and_collide(Vector2(0, -speed))
			2 : move_and_collide(Vector2(0, speed))

func ChangeHP(new):
	$TextureProgress.value = new

func Move(playerpos, map, mapsize):
	var left = costMove(pos.x-1, pos.y, playerpos, map, mapsize)
	var right = costMove(pos.x+1, pos.y, playerpos, map, mapsize)
	var top = costMove(pos.x, pos.y-1, playerpos, map, mapsize)
	var bottom = costMove(pos.x, pos.y+1, playerpos, map, mapsize)
	
	if left < right and left < top:
		direction = 4
	if right < left and right < top:
		direction = 6
	if top < right and top < bottom:
		direction = 8
	if bottom < right and bottom < top:
		direction = 2
	

func costMove(x, y, playerpos, map, mapsize):
	if not IsValid(x, y, mapsize):
		return 9999
	else:
		if x > 1 and y > 1 and x < mapsize.x-2 and y < mapsize.y-2:
			if map[x][y].type != "empty":
				return 9999
			else:
				return abs(playerpos.x - x) + abs(playerpos.y - y)
		else:
			return abs(playerpos.x - x) + abs(playerpos.y - y)

func IsValid(x, y, mapsize):
	if x > 0 and y > 0 and x < mapsize.x and y < mapsize.y:
		return true
	return false

func _on_Area2D_area_entered(area):
	if area.is_in_group("Tile"):
		wait = true
		$Timer.start(speed)
		yield($Timer, "timeout")
		wait = false

	if area.is_in_group("Attack"):
		$"../../Scripts/Variables".DamageEnemy(id)

extends Node

onready var Cell = load("res://Scenes/Code/Cell.gd")
onready var Tile = preload("res://Scenes/RogueMap/Tile.tscn")
onready var TileWall = preload("res://Scenes/RogueMap/TileWall.tscn")
onready var Rock = preload("res://Scenes/RogueMap/Objects/Rock.tscn")
onready var Entities = $"../../Entities"

func GenerateMap(mapsize, offset):
	var map = []
	for x in range(0, mapsize.x):
		map.append([])
		for y in range(0, mapsize.y):
			map[x].append([])
			map[x][y] = Cell.new()
			map[x][y].pos = Vector2(x, y)
			map[x][y].position = map[x][y].pos * offset
			if y == 0 or x == 0 or x == mapsize.x-1 or y == mapsize.y-1:
				map[x][y].item = Cell.type.wall
	return map

func GenerateRocks(map, mapsize):
	randomize()
	for x in range(0, mapsize.x):
		for y in range(0, mapsize.y):
			if x % 10 == 0 or x % 9 == 0 or y % 10 == 0 or y % 9 == 0:
				if map[x][y].item == Cell.type.empty:
					var chance = randi()%4+1
					if chance == 2:
						map[x][y].item = Cell.type.rock

func InstantiateMap(map, mapsize):
	for x in range(0, mapsize.x):
		for y in range(0, mapsize.y):
			if map[x][y].item == Cell.type.wall or map[x][y].item == Cell.type.rock:
				if map[x][y].item == Cell.type.wall:
					map[x][y].object = TileWall.instance()
				if map[x][y].item == Cell.type.rock:
					map[x][y].object = Rock.instance()
				map[x][y].object.global_transform.origin = Vector3(map[x][y].position.x, 0, map[x][y].position.y)
				Entities.add_child(map[x][y].object)
			map[x][y].Tile = Tile.instance()
			map[x][y].Tile.global_transform.origin = Vector3(map[x][y].position.x, 0, map[x][y].position.y)
			$"../../Tiles".add_child(map[x][y].Tile)

func SetDarkMap(map, mapsize, Player):
	for x in range(0, mapsize.x):
		for y in range(0, mapsize.y):
			if x > Player.x - 4 and x < Player.x + 4 and y > Player.y - 4 and y < Player.y + 4:
				if map[x][y].object != null:
					map[x][y].object.show()
				map[x][y].Tile.ChangeColor(Color.white)
			else:
				if map[x][y].object != null:
					map[x][y].object.hide()
				map[x][y].Tile.ChangeColor(Color8(39, 25, 2, 255))

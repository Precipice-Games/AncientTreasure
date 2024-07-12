extends Camera2D

@export var player1:CharacterBody2D
@export var player2:CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	follow_players()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# check if player 1 is "null", then follow player 2
	# otherwise check if player 2 is "null", and if so then use PLayer1's position for both
	if player1 == null:
		follow_player(player2)
	elif player2 == null:
		follow_player(player1)
	else:
		follow_players()
	
func follow_players():
	global_position = (player1.global_position + player2.global_position) / 2
	var spread = abs(player1.global_position - player2.global_position)
	var xscale:float = get_viewport_rect().size.x / spread.x
	var yscale:float = get_viewport_rect().size.y / spread.y
	var scale = 0.67 * min(xscale, yscale, 1.5)
	zoom = Vector2(scale, scale)

func follow_player(player):
	# check if player 1 is "null", and if so then use Player2's position for both
	# otherwise check if player 2 is "null", and if so then use PLayer1's position for both
	global_position = player.global_position
	#var spread = abs(player1.global_position - player2.global_position)
	#var xscale:float = get_viewport_rect().size.x / spread.x
	#var yscale:float = get_viewport_rect().size.y / spread.y
	#var scale = 0.67 * min(xscale, yscale, 1.5)
	#zoom = Vector2(scale, scale)
	

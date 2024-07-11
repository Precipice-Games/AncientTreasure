extends Camera2D

@export var player1:CharacterBody2D
@export var player2:CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	follow_players()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	follow_players()
	
func follow_players():
	global_position = (player1.global_position + player2.global_position) / 2
	var spread = abs(player1.global_position - player2.global_position)
	var xscale:float = get_viewport_rect().size.x / spread.x
	var yscale:float = get_viewport_rect().size.y / spread.y
	var scale = 0.67 * min(xscale, yscale, 1.5)
	zoom = Vector2(scale, scale)
	

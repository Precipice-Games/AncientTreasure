extends CharacterBody2D

signal landed

var coins:int = 0

@export var walk_speed = 800.0
@export var jump_speed = -700.0

@onready var animatedSprite = $AnimatedSprite2D

@export var bullet_scene:PackedScene = preload("res://Scenes/bullet.tscn")
# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity:int = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 0
var grounded = false

signal damaged(amount)
signal coin_collected(amount)

const HP_MAX = 150.0
var hp = HP_MAX

func _ready():
	var hud = get_tree().get_first_node_in_group("HUD_2")
	connect("damaged",hud._on_player_2_damaged)
	connect("coin_collected",hud._on_player_collect)

#Only runs when input happens
func _input(event):
	if Input.is_action_pressed("jump_2") and is_on_floor():
		jump()
	if event.is_action("move_2"):
		move(Input.get_axis("move_left_2", "move_right_2"))
	if Input.is_action_pressed("attack_2"):
		var bullet = bullet_scene.instantiate()
		bullet.initialize(self.direction)
		get_tree().root.get_child(0).add_child(bullet)
		bullet.global_position = $Gun/Barrel.global_position

func jump():
	velocity.y = jump_speed
	animatedSprite.play("jump")


func _physics_process(delta):
	ground_check(delta)
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, walk_speed)
	else:
		velocity.x = direction * walk_speed
	
	if direction>0:
		$Gun.scale.x = 1
	else:
		$Gun.scale.x = -1
	move_and_slide()

func ground_check(delta):
	var was_grounded = grounded
	grounded = is_on_floor()
	if not grounded:
		velocity.y += gravity * delta
	elif not was_grounded:
		landed.emit()

func move(dir):
	direction = dir
	if dir == 0:
		animatedSprite.play("idle")
	else:
		animatedSprite.play("walk")
	animatedSprite.flip_h = dir < 0


func _on_landed():
	if direction == 0:
		animatedSprite.play("idle")
	else:
		animatedSprite.play("walk")


func jump_finished():
	if grounded:
		animatedSprite.play("idle")


func take_damage(amount):
	hp-=amount
	damaged.emit(amount)
	if hp<0:
		die()

func die():
	var scene = get_tree().get_current_scene()
	print(scene.name)
	if scene.name == "level_1":
		scene.get_node("Music").stop()
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	elif scene.name == "level_2":
		scene.get_node("Music").stop()
		get_tree().change_scene_to_file("res://Scenes/player_1_win.tscn")

func collect_coin():
	coins+=1
	coin_collected.emit(coins)

extends Area2D

signal damaged(by)
signal killed()

const HP_MAX = 150.0
var hp = HP_MAX

func take_damage(impact):
	impact = clamp(impact, 0.0, 1.0)
	var damage = HP_MAX * impact
	var prev_hp = hp
	hp -= damage
	hp = clamp(hp, 0, HP_MAX)

func _on_body_entered(body):
	take_damage

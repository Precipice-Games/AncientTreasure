extends Area2D

var bounce_force:int = 2600

func _on_body_entered(body):
	$SpringSpr.play("SpringUp")
	body.velocity.y -= bounce_force

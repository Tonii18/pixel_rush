extends Area2D

func _physics_process(delta):
	$AnimatedSprite2D.play("flying")

func _on_body_entered(body):
	if body.name == "Player":  # Asegúrate de que el nodo del jugador se llame "player"
		print("¡Jugador ha chocado con el pajaro!")
		body.game_over()

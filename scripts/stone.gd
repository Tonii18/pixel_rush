extends Area2D

func _on_body_entered(body):
	if body.name == "Player":  # Asegúrate de que el nodo del jugador se llame "player"
		print("¡Jugador ha chocado con la piedra!")
		body.game_over()

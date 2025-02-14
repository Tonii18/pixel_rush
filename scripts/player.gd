extends CharacterBody2D

@export var jump_force: float = -500  # Fuerza máxima del salto
@export var gravity: float = 900  # Gravedad
@export var jump_cut_force: float = -150  # Fuerza reducida al soltar la tecla

func _ready():
	# Comprobar si el nodo de música está presente y reproducir la música
	var game_music = $GameMusic
	if game_music:
		print("🎶 Reproduciendo música de fondo")
		game_music.play()
	else:
		print("❌ No se encontró el nodo de música.")

func _physics_process(delta):
	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta  

	# Control de salto
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		$JumpSound.play()
		velocity.y = jump_force

	# Si el jugador suelta la tecla antes de alcanzar la cima del salto, corta la fuerza
	if Input.is_action_just_released("move_up") and velocity.y < 0:
		velocity.y = max(velocity.y, jump_cut_force)  

	# Control de animación
	if is_on_floor():
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("jump")

	move_and_slide()

func game_over():
	velocity = Vector2.ZERO  # Detener el movimiento del jugador
	set_physics_process(false)  # Desactiva el procesamiento físico del jugador
	
	# Reproducir animación de muerte solo si no está ya reproduciéndose
	if $AnimatedSprite2D.animation != "die":
		$AnimatedSprite2D.play("die")  # Reproducir animación de muerte
		$DieSound.play()  # Reproducir sonido de muerte
	
	# Detener la música de fondo
	var game_music = $GameMusic
	if game_music:
		print("🎶 Deteniendo la música")
		game_music.stop()
	else:
		print("❌ No se encontró el nodo de música.")
	
	# Obtener la referencia a 'World' desde 'Main'
	var world = get_parent().get_node_or_null("World")  
	if world:
		# Dentro de 'World', obtener 'ParallaxBackground'
		var parallax = world.get_node_or_null("ParallaxBackground")  
		if parallax:
			parallax.stop_movement()
		else:
			print("❌ No se encontró 'ParallaxBackground' dentro de 'World'.")
	else:
		print("❌ No se encontró 'World' dentro de 'Main'.")

	# Esperar a que termine la animación de muerte
	await $AnimatedSprite2D.animation_finished  # Esperar a que termine la animación de muerte

	# Esperar el tiempo del sonido de la muerte
	await get_tree().create_timer($DieSound.stream.get_length()).timeout  # Esperar el sonido
	
	# Después de la animación y sonido, detener cualquier movimiento
	set_physics_process(false)
	
	print("Has perdido")
	get_tree().paused = true  # Pausar el juego

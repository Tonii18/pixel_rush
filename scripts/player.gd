extends CharacterBody2D

@export var jump_force: float = -500  # Fuerza máxima del salto
@export var gravity: float = 900  # Gravedad
@export var jump_cut_force: float = -150  # Fuerza reducida al soltar la tecla

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
	print("Has perdido")
	get_tree().paused = true

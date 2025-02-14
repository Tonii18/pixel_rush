extends Node

@export var obstacles: Array[PackedScene] = []  # Lista de obstáculos que se pueden generar
@export var spawn_rate: float = 2.0  # Tiempo entre cada generación de obstáculo (en segundos)
@export var spawn_area: Rect2  # Área en la que los obstáculos pueden aparecer

var time_since_last_spawn: float = 0.0  # Controlador de tiempo entre la generación de obstáculos

func _ready():
	randomize()  # Para asegurar que los números aleatorios sean diferentes cada vez

func _process(delta):
	# Aumentar el contador de tiempo
	time_since_last_spawn += delta
	
	# Si ha pasado el tiempo suficiente, generar un nuevo obstáculo
	if time_since_last_spawn >= spawn_rate:
		spawn_obstacle()
		time_since_last_spawn = 0  # Reiniciar el contador de tiempo

func spawn_obstacle():
	# Elegir un obstáculo aleatorio de la lista
	var obstacle_scene = obstacles[randi() % obstacles.size()]
	var obstacle = obstacle_scene.instantiate()  # Crear una instancia del obstáculo
	
	# Determinar la altura del obstáculo
	if obstacle.name == "bird":  # Si es un pájaro, lo colocamos más alto
		obstacle.position.y = randf_range(100, 300)  # Ajusta los valores según la altura del pájaro
	else:  # Si es piedra o valla, se coloca en el suelo
		obstacle.position.y = 400  # Ajusta según la altura del suelo de tu juego
	
	# Colocamos el obstáculo en una posición horizontal aleatoria
	obstacle.position.x = 1280  # O el valor que corresponda según el ancho de tu pantalla o escenario

	# Añadir el obstáculo a la escena
	get_parent().add_child(obstacle)

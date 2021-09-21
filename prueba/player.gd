extends Area2D

export (int) var velocidad #Se crea una variable accesible desde la barra de atributos
var movimiento = Vector2() #Se crea una variable de movimiento de x,y (vector 2 hace referencia a 2D)
var limite #Variable para guardar el tamaño de la pantalla 


# Called when the node enters the scene tree for the first time.
func _ready():
	limite = get_viewport_rect().size #Toma el valor de la pantalla

func _process(delta):
	movimiento = Vector2() #detiene el movimiento del personaje para que no sea un movimiento perpetuo
	$AnimatedSprite.animation = "frente" #resetea la imagen despues de hacer un golpe
	
	#crea el movimiento del personaje segun la tecla que se oprima
	if Input.is_action_pressed("ui_right"):
		movimiento.x += 2
	if Input.is_action_pressed("ui_left"):
		movimiento.x -= 2
	if Input.is_action_pressed("ui_down"):
		movimiento.y += 2
	if Input.is_action_pressed("ui_up"):
		movimiento.y -= 2
	if movimiento.length() > 0: 
		movimiento = movimiento.normalized() * velocidad #a que velocidad el personaje se movera
		
	position += movimiento * delta #delta es la velocidad de la pc y crea el movimiento
	#mantiene el personaje dentro de los limites
	position.x = clamp(position.x, 0, limite.x) 
	position.y = clamp(position.y, 0, limite.y)
	
	#Voltea la imagen si la tecla que se oprime es a la izquierda
	if movimiento.x != 0:
		$AnimatedSprite.flip_h = movimiento.x < 0
	
	
	#Pregunta si se aprietan los botones para hacer los golpes
	if Input.is_action_pressed("ui_page_down"):
		$AnimatedSprite.animation = "pateando"
	
	if Input.is_action_pressed("ui_page_up"):
		$AnimatedSprite.animation = "golpe"
	


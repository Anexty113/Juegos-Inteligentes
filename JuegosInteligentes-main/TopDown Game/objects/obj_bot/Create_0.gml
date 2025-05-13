// Inherit the parent event
event_inherited();

#region variables
spd = 1
dir = 0
xspd = 0
yspd = 0
face = 1
detection_radius = 350
moveSpd = spd
acum_dmg = 0

distance = detection_radius
cooldown_timer=0
cooldown_action=0
shield_active = false
cooldown_action_status = 0
opponent_hp = 0

distance_food = detection_radius

#endregion


#region IA
neuronal_network = instance_create_layer(x,y, "Instances", obj_neuronal_network)
fitness = 0
opponent = obj_enemyA
//neuronal_network.b = [[0]]
//neuronal_network.w[0][0] = 1
//neuronal_network.w[0][1] = 0

#region funciones de soporte
function argmax(arr) {
    // Verificar que el array no esté vacío
    if (array_length(arr) == 0) {
        return -1; // Retorna -1 si el array está vacío
    }

    // Inicializar el valor y el índice máximo
    var max_valor = arr[0];
    var max_indice = 0;

    // Obtener la longitud del array
    var longitud = array_length(arr);

    // Recorrer el array desde el segundo elemento
    for (var i = 1; i < longitud; i++) {
        if (arr[i] > max_valor) {
            max_valor = arr[i];
            max_indice = i;
        }
    }

    // Retornar el índice del valor máximo
    return max_indice;
}

function encontrar_objeto_mas_cercano(x, y,radio, objeto_tipo) {
    var instancia_mas_cercana = noone;
    var distancia_minima = radio; // Iniciamos con el radio máximo permitido

    // Si no se especifica un tipo de objeto, buscamos entre todos los objetos
    if (argument_count < 4 || is_undefined(objeto_tipo)) {
        // Recorremos todas las instancias en la room
        with (all) {
            // Evitar considerar la instancia que llama a la función (si es el caso)
            if (id != other.id) {
                var dist = point_distance(x, y, x, y);

                // Si la distancia es menor que la distancia mínima y dentro del radio
                if (dist < distancia_minima) {
                    distancia_minima = dist;
                    instancia_mas_cercana = id;
                }
            }
        }
    } else {
        // Recorremos todas las instancias del tipo especificado
        with (objeto_tipo) {
            // Evitar considerar la instancia que llama a la función
            if (id != other.id) {
                var dist = point_distance(x, y, x, y);

                // Si la distancia es menor que la distancia mínima y dentro del radio
                if (dist < distancia_minima) {
                    distancia_minima = dist;
                    instancia_mas_cercana = id;
                }
            }
        }
    }

    // Retornamos la instancia más cercana encontrada o noone si no se encontró ninguna
    return instancia_mas_cercana;
}


#endregion

#region sensores
function update_sensor_matrix()
{
	var _dx = 0
	var _dy = 0
	
	// Distancia al jugador
	if instance_exists(opponent)
	{
		_dx = opponent.x - x;
		_dy = opponent.y - y;
		distance = sqrt(_dx * _dx + _dy * _dy);
	
		if (distance > detection_radius) distance=detection_radius
	
	} else
	{
		distance=detection_radius
	}
	
	// Distancia comida
	var _food = encontrar_objeto_mas_cercano(x, y,detection_radius, obj_foodparent)
	_dx = _food.x - x;
	_dy = _food.y - y;
	distance_food = sqrt(_dx * _dx + _dy * _dy);
		
	if (distance_food > detection_radius) distance_food=detection_radius
	
	//hp
	//Se modifica en step
	
	//hp del enemigo
	if (instance_exists(opponent))
	{
		opponent_hp = opponent.hp
	} else
	{
		opponent_hp = 0
	}
	
	//cooldown
	if (cooldown_action == 0) 
	{
		cooldown_action_status = 0
	} else
	{
		cooldown_action_status = 1
	}
	
}


function get_sensor_matrix(){
	var _matrix = create_random_matrix(neuronal_network.n_inputs, 1,-1,1)
	//show_debug_message("random matrix = "+string(_matrix))
	_matrix[0][0] = 1-(distance/detection_radius)
	_matrix[1][0] = 1-(distance_food/detection_radius)
	_matrix[2][0] = hp/10
	_matrix[3][0] = opponent_hp/10
	_matrix[4][0] = cooldown_action_status

	//show_debug_message("random matrix = "+string(_matrix))
	return _matrix
}

#endregion

#region fitness

function update_fitness()
{
	//Daño al bot
	fitness = -acum_dmg
	
	//Daño causado
	if (instance_exists(opponent)) fitness += opponent.acum_dmg
	
}


#endregion

function get_inputs(){
	var _x = get_sensor_matrix()
	var _y = neuronal_network.evaluate(_x)
	
	show_debug_message("y = "+string(_y))
	show_debug_message("resultado = "+string(argmax(_y[0])))
	
	return argmax(_y[0])
	
	
	//if (_y[0][0] > 0.5) {
	//	if(on_orb_n) show_debug_message("SALTA!")
	//	return true
	//}
	//return false
}

#endregion
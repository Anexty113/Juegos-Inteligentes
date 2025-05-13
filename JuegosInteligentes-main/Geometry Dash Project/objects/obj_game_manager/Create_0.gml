#region gestion de parametros

function file_read_all_text(_filename) {
    if (!file_exists(_filename)) {
        return undefined;
    }
    
    var _buffer = buffer_load(_filename);
    var _result = buffer_read(_buffer, buffer_string);
    buffer_delete(_buffer);
    return _result;
}

function file_write_all_text(_filename, _content) {
    var _buffer = buffer_create(string_length(_content), buffer_grow, 1);
    buffer_write(_buffer, buffer_string, _content);
    buffer_save(_buffer, _filename);
    buffer_delete(_buffer);
}

function save_parameters(_filename)
{
	inv_list(best_w)
	inv_list(best_b)
    var data = {
        weights: best_w[|0],
        biases: best_b[|0]
    };
   
   show_debug_message("mejor w guardado "+ string(best_w[|0][0]));
   
   var _json_content = json_stringify(data);
   file_write_all_text(_filename, _json_content);
}

function json_load(_filename) {
    var _json_content = file_read_all_text(_filename);
    if (is_undefined(_json_content))
        return undefined;
    
    try {
        return json_parse(_json_content);
    } catch (_) {
        // if the file content isn't a valid JSON, prevent crash and return undefined instead
        return undefined;
    }
}





#endregion

#region Funciones
function create_player_human(){
	return instance_create_layer(x,y, "Instances", obj_human)
}


function create_player_bot(){
	return instance_create_layer(x,y, "Instances", obj_bot)
}

function create_best_bot(){
	var _best_bot = instance_create_layer(x,y, "Instances", obj_bot)
	var _save_parameters = json_load("parametros1_v6.json")
	var _best_w
	var _best_b
	
	_best_w = _save_parameters.weights
	_best_b = _save_parameters.biases
	
	show_debug_message("mejor w cargado "+ string(_best_w));
	
	_best_bot.neuronal_network.w = _best_w
	_best_bot.neuronal_network.b = _best_b
	return _best_bot
}

function create_player_flyer(){
	return instance_create_layer(x,y, "Instances", obj_player_flyer)
}


function restart_level(){
	attempts += 1
	if instance_exists(obj_mushroom_pulse){
		with (obj_mushroom_pulse){
			sprite_index = spr_mushroom_pulse_down
		}
	}
	
	if instance_exists(obj_enemy) {
		with (obj_enemy){
			reiniciar_enemigo()
		}
	}
	
	if instance_exists(obj_gravity_button){
		with (obj_gravity_button){
			sprite_index = spr_gravity_button_off
		}
	}
	
	if instance_exists(obj_transformer){
		with (obj_transformer) {
			transformed = false
		}
	}
	
	create_player_human()
}

#endregion

attempts = 0

function inv_list(_list)
{
	var list_size = ds_list_size(_list);

	// Bucle desde el inicio hasta la mitad de la lista
	for (var i = 0; i < list_size / 2; i++) {
	    var opposite_index = list_size - 1 - i;
    
	    // Intercambiar los elementos en los índices 'i' y 'opposite_index'
	    var temp = _list[| i];
	    _list[| i] = _list[| opposite_index];
	    _list[| opposite_index] = temp;
}
}

#region Genetic

function two_point_crossover(parent1, parent2) {
    var genome_size = array_length(parent1.w) + array_length(parent1.b);
    
    // Crear los genomas
    var genome1 = array_create(genome_size);
    var genome2 = array_create(genome_size);
    
    // Combinar pesos y biases en un solo vector
    var index = 0;
    for (var i = 0; i < array_length(parent1.w); i++) {
        genome1[index] = parent1.w[i];
        genome2[index] = parent2.w[i];
        index += 1;
    }
    for (var i = 0; i < array_length(parent1.b); i++) {
        genome1[index] = parent1.b[i];
        genome2[index] = parent2.b[i];
        index += 1;
    }
    
    // Seleccionar dos puntos de cruce
    var point1 = irandom(genome_size - 2);
    var point2 = irandom_range(point1 + 1, genome_size - 1);
    
    // Crear los hijos
    var child_genome1 = array_create(genome_size);
    var child_genome2 = array_create(genome_size);
    for (var i = 0; i < genome_size; i++) {
        if (i <= point1 || i > point2) {
            child_genome1[i] = genome1[i];
            child_genome2[i] = genome2[i];
        } else {
            child_genome1[i] = genome2[i];
            child_genome2[i] = genome1[i];
        }
    }
    
    // Separar los genomas en pesos y biases nuevamente (similar al ejemplo anterior)
    var child1 = { w: array_create(array_length(parent1.w)), b: array_create(array_length(parent1.b)) };
    var child2 = { w: array_create(array_length(parent1.w)), b: array_create(array_length(parent1.b)) };
    
    index = 0;
    for (var i = 0; i < array_length(parent1.w); i++) {
        child1.w[i] = child_genome1[index];
        child2.w[i] = child_genome2[index];
        index += 1;
    }
    for (var i = 0; i < array_length(parent1.b); i++) {
        child1.b[i] = child_genome1[index];
        child2.b[i] = child_genome2[index];
        index += 1;
    }
    
    return [child1, child2];
}


#endregion


//IA
#region IA

n_players = 40
n_generations = 0

bots = ds_list_create()

function create_bot(){
	var _xoffset = 0
	var _bot = instance_create_layer(x+_xoffset, y,  "Instances", obj_bot)
	_bot.image_blend = make_color_hsv(random_range(0,255), 255, 255)
	return _bot

}

function init_gen(_n)
{
	repeat(_n)
	{
		var _bot = create_bot()
		ds_list_add(bots, _bot)
	}
	show_debug_message("Número de bots: " + string(instance_number(obj_bot)));
	show_debug_message("Número de redes: " + string(instance_number(obj_neuronal_network)));
}

function next_gen()
{
	show_debug_message("NUEVA GENERACION")
	// Destruir las instancias de los bots antiguos
    for (var i = 0; i < ds_list_size(bots); i++)
    {
        var bot_instance = bots[| i];
        if (instance_exists(bot_instance))
        {
            instance_destroy(bot_instance);
        }
    }
	ds_list_clear(bots)
	
	inv_list(best_w)
	inv_list(best_b)
	
	//show_debug_message(string(best_w[|0]))
	//show_debug_message(string(best_b[|0]))
	
	var _bestbot = create_bot()
	_bestbot.neuronal_network.w = best_w[|0]
	_bestbot.neuronal_network.b = best_b[|0]
	show_debug_message("w del mejor1 "+string(best_w[|0][0]))
	//save_parameters("parametros1.json")
	//show_debug_message("Número de bots: " + string(instance_number(obj_bot)));
	init_gen(n_players)
	
	var _prob_w
	var _prob_b
	var _offset
	
	for (var _i = 0; _i < n_players; _i++)
	{
		//configuracion parametros de mutacion
		if(random(100)<50)
		{
			_prob_w = 60
			_prob_b = 30
			_offset = 2
		}
		else
		{
			_prob_w = 20
			_prob_b = 10
			_offset = 0.5
		}
		
		var _pob = bots[|_i]
		
		//Capa 1
		var w1 = best_w[|0][0]
		var b1 = best_b[|0][0]
		
		w1 = mutate_matrix(w1, _prob_w, _offset)
		b1 = mutate_matrix(b1, _prob_b, _offset)
		
		//Capa 2
		//var w2 = best_w[|0][1]
		//var b2 = best_b[|0][1]
		
		//w2 = mutate_matrix(w2, _prob_w+10, _offset+2)
		//b2 = mutate_matrix(b2, _prob_b+10, _offset+2)
		
		_pob.neuronal_network.w = [w1]
		_pob.neuronal_network.b = [b1]
	}
	show_debug_message("w del mejor2 "+string(best_w[|0][0]))
	ds_list_add(bots, _bestbot)
	
	n_generations += 1
	
	ds_list_clear(best_w)
	ds_list_clear(best_b)
	
	//mutate_matrix(best_w, 50, -0.1, 0.1)
}


best_w = ds_list_create()
best_b = ds_list_create()

init_gen(n_players)
//create_best_bot()
//create_player_human()

#endregion



cam = instance_create_layer(x,y, "Instances", obj_camera)

//player = create_bot()
//camera = instance_create_layer(x,y, "Instances", obj_camera)
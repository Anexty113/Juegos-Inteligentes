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

function restart_level(){
	attempts += 1
	
	create_player_human()
}

// Ordenar las listas por el fitness de cada bot
function update_parameters(n_bots)
{
// Paso 1: Combinar los datos en una estructura unificada
	var size = ds_list_size(obj_game_manager.best_fitness);
	var combined_list = [];

	for (var i = 0; i < size; i++) {
	    var entry = {
	        fitness: obj_game_manager.best_fitness[| i],
	        w: obj_game_manager.best_w[| i],
	        b: obj_game_manager.best_b[| i]
	    };
	    array_push(combined_list, entry);
	}

	// Paso 2: Ordenar la estructura unificada basándote en 'fitness'
	array_sort(combined_list, function(a, b) {
	      return b.fitness - a.fitness; // Orden descendente
	  });

	// Paso 3: Extraer el top N de bots
	var N = n_bots; // Reemplaza 'desired_number_of_bots' por el número que desees
	if (array_length(combined_list) > N) {
	    array_resize(combined_list, N);
	}

	// Paso 4: Actualizar las listas originales
	ds_list_clear(obj_game_manager.best_w);
	ds_list_clear(obj_game_manager.best_b);
	ds_list_clear(obj_game_manager.best_fitness);

	for (var i = 0; i < array_length(combined_list); i++) {
	    ds_list_add(obj_game_manager.best_w, combined_list[i].w);
	    ds_list_add(obj_game_manager.best_b, combined_list[i].b);
	    ds_list_add(obj_game_manager.best_fitness, combined_list[i].fitness);
	}

	combined_list = undefined;
	save_parameters("parameters_topdown_v1.json")
	
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

n_players = 20
n_generations = 0

bots = ds_list_create()
enemies = ds_list_create()

function create_bot(){
	var _xoffset = 0
	var _bot = instance_create_layer(x+_xoffset, y,  "Instances", obj_bot)
	_bot.image_blend = make_color_hsv(random_range(0,255), 255, 255)
	return _bot

}

function create_enemy(type){
	var _obj_enemy
	
	if (type=="A")
	{
		obj_enemy = obj_enemyA
	} else if (type="B")
	{
		obj_enemy = obj_enemyB
	} else if (type="C")
	{
		obj_enemy = obj_enemyC
	} else
	{
		obj_enemy = obj_enemyA
	}
	
	
	var _xoffset = 0
	var _bot = instance_create_layer(x+_xoffset, y,  "Instances", obj_enemy)
	_bot.image_blend = make_color_hsv(random_range(0,255), 255, 255)
	return _bot

}

function init_gen(_n)
{
	repeat(_n)
	{
		var _bot = create_bot()
		ds_list_add(bots, _bot)
		
		var _enemy = create_enemy("A")
		ds_list_add(enemies, _enemy)
	}
	show_debug_message("Número de bots: " + string(instance_number(obj_bot)));
	show_debug_message("Número de redes: " + string(instance_number(obj_neuronal_network)));
	
	// **Nuevo Bloque: Asignar Oponentes**
    var num_bots = ds_list_size(bots);
    var num_enemies = ds_list_size(enemies);
    var num_pairs = min(num_bots, num_enemies);

    for (var i = 0; i < num_pairs; i++) {
        var bot_instance = ds_list_find_value(bots, i);
        var enemy_instance = ds_list_find_value(enemies, i);
        
        if (instance_exists(bot_instance) && instance_exists(enemy_instance)) {
            bot_instance.opponent = enemy_instance;
            enemy_instance.opponent = bot_instance;
        } else {
            show_debug_message("Error: bot_instance o enemy_instance no existen en el índice " + string(i));
        }
    }

    // **Fin del Bloque de Asignación de Oponentes**
	
	
	// Obtener una lista de las instancias de spawners de bots
	var num_spawners_bots = instance_number(obj_spawner_bot);
	var spawner_bots = array_create(num_spawners_bots);

	for (var i = 0; i < num_spawners_bots; i++) {
	    var spawner_instance = instance_find(obj_spawner_bot, i);
	    spawner_bots[i] = spawner_instance;
	}


	// Obtener una lista de las instancias de spawners de enemigos
	var num_spawners_enemies = instance_number(obj_spawner_enemy);
	var spawner_enemies = array_create(num_spawners_enemies);

	for (var i = 0; i < num_spawners_enemies; i++) {
	    var spawner_instance = instance_find(obj_spawner_enemy, i);
	    spawner_enemies[i] = spawner_instance;
	}

//------------
	// asignar bots a spawners
	var num_bots = ds_list_size(bots);
	var bots_to_assign = min(num_bots, num_spawners_bots);

	for (var i = 0; i < bots_to_assign; i++) {
	    var bot_instance = ds_list_find_value(bots, i);
	    var spawner_instance = spawner_bots[i];
    
	    if (instance_exists(bot_instance) && instance_exists(spawner_instance)) {
	        bot_instance.x = spawner_instance.x;
	        bot_instance.y = spawner_instance.y;
        
	        with (spawner_instance) {
	            spawned = true;
	        }
	    } else {
	        show_debug_message("Error: bot_instance o spawner_instance no existen en la asignación de bots.");
	    }
	}

	//asignar enemigos a spawners
	var num_enemies = ds_list_size(enemies);
	var enemies_to_assign = min(num_enemies, num_spawners_enemies, bots_to_assign); // Aseguramos que no exceda bots_to_assign

	for (var i = 0; i < enemies_to_assign; i++) {
	    var enemy_instance = ds_list_find_value(enemies, i);
	    var spawner_instance = spawner_enemies[i];
	    var bot_instance = ds_list_find_value(bots, i);
    
	    if (instance_exists(enemy_instance) && instance_exists(spawner_instance) && instance_exists(bot_instance)) {
	        enemy_instance.opponent = bot_instance;
	        enemy_instance.x = spawner_instance.x;
	        enemy_instance.y = spawner_instance.y;
        
	        with (spawner_instance) {
	            spawned = true;
	        }
	    } else {
	        show_debug_message("Error: enemy_instance, spawner_instance o bot_instance no existen en la asignación de enemigos.");
	    }
	}


//------------

	// Para bots no asignados
//	for (var i = bots_to_assign; i < num_bots; i++) {
//	    var bot_instance = ds_list_find_value(bots, i);
//	    instance_destroy(bot_instance);
//	}

	// Destruir enemigos no asignados
//	for (var i = enemies_to_assign; i < num_enemies; i++) {
//	    var enemy_instance = ds_list_find_value(enemies, i);
//	    instance_destroy(enemy_instance);
//	}

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
	
	for (var i = 0; i < ds_list_size(enemies); i++)
    {
        var enemy_instance = enemies[| i];
        if (instance_exists(enemy_instance))
        {
            instance_destroy(enemy_instance);
        }
    }
	ds_list_clear(enemies)
	
	//obtener mejor bot
	
	update_parameters(6)
	
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
	//ds_list_add(bots, _bestbot)
	
	//Asignacion mejor bot---------
	var bot_instance = ds_list_find_value(bots, 0);
	instance_destroy(bot_instance);
	
	ds_list_insert(bots, 0, _bestbot);
	
	var _spawner_instance = instance_find(obj_spawner_bot, 0)
	_bestbot.x = _spawner_instance.x;
	_bestbot.y = _spawner_instance.y;
	
	var _enemy_instance = ds_list_find_value(enemies, 0)
	_enemy_instance.opponent = _bestbot
	
	_bestbot.opponent = _enemy_instance
	
	
	
	//---------------
	
	n_generations += 1
	
	ds_list_clear(best_w)
	ds_list_clear(best_b)
	ds_list_clear(best_fitness)
	
	//mutate_matrix(best_w, 50, -0.1, 0.1)
}


best_w = ds_list_create()
best_b = ds_list_create()
best_fitness = ds_list_create()

init_gen(n_players)
//create_best_bot()
//create_player_human()

#endregion



cam = instance_create_layer(x,y, "Instances", obj_camera)


//player = create_bot()
//camera = instance_create_layer(x,y, "Instances", obj_camera)
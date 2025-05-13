hspd = 0
vspd = 0

run_spd = 4

grav = 0.5
max_vspd = 8
inverted_gravity = false

jump = -7.5
boosted = false
on_ground = 0
_wall_in_front = 0

transformation = false

double_jump = false
has_double_jumped = false

_max_jump = (jump*jump)/(2*grav)

on_orb = false
on_orb_n = 0

function get_player_input()
{
	return keyboard_check(vk_space)
}


// IA
general_range_detection = 1000
general_range_detection_y = 200

spike_detection_range = general_range_detection
dist_to_spike = spike_detection_range

wall_detection_range = general_range_detection
dist_to_wall = wall_detection_range

mushroom_detection_range = general_range_detection
dist_to_mushroom = mushroom_detection_range

orb_detection_range = general_range_detection
dist_to_orb = orb_detection_range

floor_detection_range = general_range_detection_y
dist_to_floor = floor_detection_range

ceil_detection_range = general_range_detection_y
dist_to_ceil = ceil_detection_range

spike_height = noone
spike_width = noone

dist_up = general_range_detection
dist_down = general_range_detection

dist_all = general_range_detection

dist_to_spike_y = general_range_detection_y


yoffset = 70

transformation_n = 0
over_ceil = 0

//verificar ancho y alto de la pua

function find_nearest_object_lineal(_obj) 
{
	var _list = ds_list_create()
	var _n_collisions = collision_line_list(x, bbox_bottom-10, x+general_range_detection, bbox_bottom-10, _obj, false, true, _list, true)
	if(_n_collisions != 0) 
	{
		var _result = _list[|0]
		ds_list_destroy(_list)
		return _result
	}
	ds_list_destroy(_list)
	return noone
}

function find_nearest_object_lineal_up() 
{
    var _list = ds_list_create();
    var _n_collisions = collision_line_list(x, bbox_bottom-yoffset, x + general_range_detection, bbox_bottom-yoffset, all, false, true, _list, true);
    if (_n_collisions != 0) 
    {
        var _result = noone;
        var list_size = ds_list_size(_list);
        for (var i = 0; i < list_size; i++) 
        {
            var obj = _list[| i];
            if (obj.object_index != obj_bot and obj.object_index != obj_goal_bot)
            {
                _result = obj;
                break; // Salir del bucle una vez encontrado
            }
        }
        ds_list_destroy(_list);
        return _result;
    }
    ds_list_destroy(_list);
    return noone;
}

function find_nearest_object_lineal_down() 
{
    var _list = ds_list_create();
    var _n_collisions = collision_line_list(x, bbox_bottom+yoffset, x + general_range_detection, bbox_bottom+yoffset, all, false, true, _list, true);
    if (_n_collisions != 0) 
    {
        var _result = noone;
        var list_size = ds_list_size(_list);
        for (var i = 0; i < list_size; i++) 
        {
            var obj = _list[| i];
            if (obj.object_index != obj_bot and obj.object_index != obj_wall_base and obj.object_index != obj_goal_bot)
            {
                _result = obj;
                break; // Salir del bucle una vez encontrado
            }
        }
        ds_list_destroy(_list);
        return _result;
    }
    ds_list_destroy(_list);
    return noone;
}


function find_nearest_object_lineal_all() 
{
    var _list = ds_list_create();
    var _n_collisions = collision_line_list(x, bbox_bottom - 10, x + general_range_detection, bbox_bottom - 10, all, false, true, _list, true);
    if (_n_collisions != 0) 
    {
        var _result = noone;
        var list_size = ds_list_size(_list);
        for (var i = 0; i < list_size; i++) 
        {
            var obj = _list[| i];
            if (obj.object_index != obj_bot and obj.object_index != obj_goal_bot and obj.object_index != obj_mushroom_pulse and obj.object_index != obj_jump_orb)
            {
                _result = obj;
                break;
            }
        }
        ds_list_destroy(_list);
        return _result;
    }
    ds_list_destroy(_list);
    return noone;
}


function find_nearest_object(_obj) 
{
    var _list = ds_list_create();
    var detection_height = general_range_detection_y; // Altura que deseas cubrir
    var detection_width = general_range_detection; // Ancho de detección

    // Definir las coordenadas del rectángulo de detección
    var x1 = x;
    var y1 = y - detection_height / 2;
    var x2 = x + detection_width;
    var y2 = y + detection_height / 2;

    var _n_collisions = collision_rectangle_list(x1, y1, x2, y2, _obj, false, true, _list, true);
    if (_n_collisions > 0) 
    {
        var nearest_object = _list[| 0];
        ds_list_destroy(_list); // Asegúrate de destruir la lista para liberar memoria
        return nearest_object;
    }
    ds_list_destroy(_list); 
    return noone;
}


function find_distance_below(_obj) 
{
	
	var _list = ds_list_create()
	var _n_collisions = collision_line_list(x, bbox_bottom-10,x, bbox_bottom-10+floor_detection_range, _obj, false, true, _list, true)
	if(_n_collisions != 0) 
	{
		var _result = _list[|0]
		ds_list_destroy(_list)
		return _result
	}
	ds_list_destroy(_list)
	return noone
}

function find_distance_above(_obj) 
{
	var _list = ds_list_create()
	var _n_collisions = collision_line_list(x, bbox_top,x, bbox_top-ceil_detection_range, _obj, false, true, _list, true)
	if(_n_collisions != 0) 
	{
		var _result = _list[|0]
		ds_list_destroy(_list)
		return _result
	}
	ds_list_destroy(_list)
	return noone
}


function update_sensors_data()
{
	// spike mas cercano
	var _nearest_spike = find_nearest_object_lineal(obj_spike)
	dist_to_spike = spike_detection_range
	spike_height = 0
	spike_width = 0
	if (_nearest_spike != noone)
	{
		dist_to_spike = point_distance(x,0, _nearest_spike.x, 0)
		// altura de pua mas cercana
		spike_height = _nearest_spike.bbox_bottom - _nearest_spike.bbox_top
		//anchura de pua mas cercana
		spike_width = _nearest_spike.bbox_right - _nearest_spike.bbox_left
		//distancia y del spike
		dist_to_spike_y = point_distance(0,y, 0, _nearest_spike.y)
	}
	// Muro mas cercado
	var _nearest_wall = find_nearest_object_lineal(obj_wall_base)
	dist_to_wall = wall_detection_range
	if (_nearest_wall != noone)
	{
		dist_to_wall = point_distance(x,0, _nearest_wall.x, 0)
	}
	
	//Hongo mas cercano
	var _nearest_mushroom = find_nearest_object_lineal(obj_mushroom_pulse)
	dist_to_mushroom = mushroom_detection_range
	if (_nearest_mushroom != noone)
	{
		dist_to_mushroom = point_distance(x,0, _nearest_mushroom.x, 0)
	}
	
	//Orbe mas cercano
	var _nearest_orb = find_nearest_object_lineal(obj_jump_orb)
	dist_to_orb = orb_detection_range
	if (_nearest_orb != noone)
	{
		dist_to_orb = point_distance(x,0, _nearest_orb.x, 0)
	}
	
	// Distancia hacia abajo
	var _distance_floor = find_distance_below(obj_spike)
	dist_to_floor = floor_detection_range
	if (_distance_floor != noone)
	{
		dist_to_floor = point_distance(0,y, 0, _distance_floor.y)
		//if ((dist_to_floor/_max_jump)<0.02) dist_to_floor=0
	}
	//Distancia del techo
	var _distance_ceil = find_distance_above(obj_spike)
	dist_to_ceil = ceil_detection_range-100
	if (_distance_ceil != noone)
	{
		dist_to_ceil = point_distance(0,y, 0, _distance_ceil.y)
	}
	
	//Cualquier objeto mas cercano
	var _up = find_nearest_object_lineal_up()
	var _down = find_nearest_object_lineal_down()
	var _ahead = find_nearest_object_lineal_all()
	dist_up = general_range_detection
	dist_down = general_range_detection
	dist_all = general_range_detection
	if (_up != noone)
	{
		dist_up = point_distance(x,0, _up.x, 0)
	}
	if (_down != noone)
	{
		dist_down = point_distance(x,0, _down.x, 0)
	}
	if (_ahead != noone)
	{
		dist_all = point_distance(x,0, _ahead.x, 0)
	}
	
	if (transformation) 
	{
	transformation_n = 1
	}
	else
	{
	transformation_n = 0
	}
	
	if (1-((dist_to_ceil/100))!=0) 
	{
	over_ceil = 1
	}
	else
	{
	over_ceil = 0
	}
	
	//Encima del orbe
	//on_orb = place_meeting(x, y, obj_jump_orb) || place_meeting(x, y+1, obj_jump_orb) || place_meeting(x, y-1, obj_jump_orb) || place_meeting(x, y+2, obj_jump_orb) || place_meeting(x, y+3, obj_jump_orb) || place_meeting(x, y-2, obj_jump_orb) || place_meeting(x, y-3, obj_jump_orb)
	on_orb = place_meeting(x, y+1, obj_jump_orb) 
	if (on_orb) 
	{
	double_jump = true
	has_double_jumped = false
	on_orb_n = 1
	dist_down=1000
	}
	else
	{
	on_orb_n = 0
	}
	
	//Normalizacion objeto mas cercano
	if (dist_to_mushroom > dist_all || dist_to_mushroom > dist_to_orb) 
	{
		dist_to_mushroom=1000
		
	}
	if (dist_to_orb > dist_all || dist_to_orb > dist_to_mushroom) 
	{
		dist_to_orb=1000
		
	}
	if (dist_all > dist_to_mushroom || dist_all > dist_to_orb) 
	{
		dist_all=1000
		
	}
}

function get_sensors_data()
{
	return [dist_to_spike, dist_to_wall, dist_to_floor, dist_to_ceil]
}
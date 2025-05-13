/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

neuronal_network = instance_create_layer(x,y, "Instances", obj_neuronal_network)
//neuronal_network.b = [[0]]
//neuronal_network.w[0][0] = 1
//neuronal_network.w[0][1] = 0

function get_sensor_matrix(){
	var _matrix = create_random_matrix(neuronal_network.n_inputs, 1,-1,1)

	_matrix[0][0] = 1-(dist_all/1000)
	_matrix[1][0] = 1-(dist_to_floor/200)
	_matrix[2][0] = over_ceil
	_matrix[3][0] = 1-(dist_up/1000)
	_matrix[4][0] = 1-(dist_down/1000)
	_matrix[5][0] = 1-(dist_to_mushroom/1000)
	_matrix[6][0] = on_orb_n
	_matrix[7][0] = transformation_n
	
	return _matrix
}

function get_inputs(){
	var _x = get_sensor_matrix()
	var _y = neuronal_network.evaluate(_x)
	
	
	static lista_id = -1;

    if (lista_id != -1 && ds_exists(lista_id, ds_type_list)) {
        ds_list_destroy(lista_id);
    }
	
	lista_id = ds_list_create()
	
	var _rightkey = keyboard_check( ord("D") );
	var _leftkey = keyboard_check( ord("A") );
    var _upkey = keyboard_check( ord("W") );
	var _downkey = keyboard_check( ord("S") );
	var _shootkey = mouse_check_button_pressed( mb_left );
	var _meleekey = mouse_check_button_pressed( mb_right );
	var _runkey = keyboard_check(vk_lcontrol)
	
	ds_list_add(lista_id, _rightkey, _leftkey, _upkey, _downkey, _shootkey, _meleekey, _runkey)
	
	//if (_y[0][0] > 0.5) {
	//	if(on_orb_n) show_debug_message("SALTA!")
	//	return true
	//}
	//return false
}
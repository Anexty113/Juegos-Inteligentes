/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

function get_inputs()
{
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
	
	return lista_id
	
}


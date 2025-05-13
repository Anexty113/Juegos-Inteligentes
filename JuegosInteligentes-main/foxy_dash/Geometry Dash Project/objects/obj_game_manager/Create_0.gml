
#region Funciones
function create_player(){
	return instance_create_layer(x,y, "Instances", obj_player)
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
	
	create_player()
}

#endregion

attempts = 0

player = create_player()
camera = instance_create_layer(x,y, "Instances", obj_camera)


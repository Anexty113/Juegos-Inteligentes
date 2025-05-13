function seguir()
{
	if (instance_exists(opponent)) {
		mp_potential_step_object(opponent.x, opponent.y, moveSpd * 2, obj_wall)
	}
}

function huir() {
    // Verificar si el oponente existe
    if (instance_exists(opponent)) {
		var dx = x - opponent.x;
		var dy = y - opponent.y;
		
        if (distance > 0) {
            dx /= distance; // Normalizar dirección
            dy /= distance;

            var opposite_x = x + dx * 100; // Punto opuesto en el plano
            var opposite_y = y + dy * 100;

            // Mover hacia el punto opuesto
            mp_potential_step_object(opposite_x, opposite_y, moveSpd * 2, obj_wall);
        }
    }
}


function ataq_cerca()
{
	if (cooldown_action==0)
	{
		var _xOffset = lengthdir_x( 21, 0);
		var _yOffset = lengthdir_y( -26, 0);
	
		instance_create_depth( x + 5 + _xOffset,  y + -23 + _yOffset, depth-100, obj_meleeforenemy); 
		instance_create_depth( x + 5 +_xOffset,  y + -23 + _yOffset, depth-100, obj_meleeforplayer); 
	
		_xOffset = lengthdir_x( 21, 270);
		_yOffset = lengthdir_y( -26, 270);
		instance_create_depth( x + _xOffset,  y + 49 +_yOffset, depth-100, obj_meleeforenemy_1); 
		instance_create_depth( x + _xOffset,  y + 49 +_yOffset, depth-100, obj_meleeforplayer_1); 
	
	
		_xOffset = lengthdir_x( 21, 180);
		_yOffset = lengthdir_y( -26, 180);
		instance_create_depth( x - 5 + _xOffset,  y + -23 + _yOffset, depth-100, obj_meleeforenemy_2); 
		instance_create_depth( x - 5 + _xOffset,  y + -23 +_yOffset, depth-100, obj_meleeforplayer_2); 
	
		_xOffset = lengthdir_x( 21, 90);
		_yOffset = lengthdir_y( -26, 90);
		instance_create_depth( x + _xOffset,  y + -90 +_yOffset, depth-100, obj_meleeforenemy_3); 
		instance_create_depth( x + _xOffset,  y + -90 +_yOffset, depth-100, obj_meleeforplayer_3); 
	
		cooldown_action = 30
	}
	if cooldown_action > 0
			{
				cooldown_action --
			}
	
}

function ataq_lejos()
{
	if (instance_exists(opponent) and cooldown_action==0) {
			dir = point_direction(x, y, opponent.x, opponent.y)
			var offset = 16; 

			// Calcular las nuevas coordenadas
			var bullet_x = x + lengthdir_x(offset, dir);
			var bullet_y = y + lengthdir_y(offset, dir);
		
			var _bulletInstp = instance_create_depth( bullet_x , bullet_y, depth-100, obj_bullet); 
			
	
			with(_bulletInstp)
			{
				dir = other.dir;
				owner = other.id
			}
			
			cooldown_action = 30
			
			}
			
			if cooldown_action > 0
			{
				cooldown_action --
			}
	}


function cubrirse() {
    if (!shield_active and cooldown_action==0) {

        moveSpd = 0;  
        shield_active = true;  
        var shield_instance = instance_create_layer(x, y, "Instances", obj_shield);
        shield_instance.target = self;  
        shield_instance.shield_max_time = 20;  
        shield_instance.active = true;  
		
    }
	if cooldown_action > 0
	{
		cooldown_action --
	}
}


function curarse()
{
	if (instance_exists(obj_foodparent) and distance_food < detection_radius){
		mp_potential_step_object(obj_foodparent.x, obj_foodparent.y, moveSpd * 2, obj_wall)
	}
}

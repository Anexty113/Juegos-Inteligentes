//Variables de movimiento
	moveDir = 0;
	moveSpd = 2;
	xspd = 0;
	yspd = 0;

opponent = obj_enemyParent
cooldown_action = 30

// Control de sprites 
	centerYOffset = -17; 
	centerY = y + centerYOffset; 

	weaponOffsetDist = 10;
	aimDir = 0;

	face = 0;
	sprite[0] = spr_playerright;
	sprite[1] = spr_playerup;
	sprite[2] = spr_playerleft;
	sprite[3] = spr_playerdown;
	
	sprite[4] = spr_meleeright;
	sprite[5] = spr_meleeup;
	sprite[6] = spr_meleeleft;
	sprite[7] = spr_meleedown;

// Vida y escudo 
	hp = 10
	
	// Inicialización de variables relacionadas con el escudo
	shield_active = false;       // Determina si el escudo está activo
	cooldown_timer = 0;  // Contador para el cooldown del escudo
	shield_cooldown_time = 3;    // Tiempo de cooldown del escudo en segundos
	shield_instance = obj_shield

//infoarmacion del arma
	shootTimer = 0;
	shootCooldown = 11;

	bulletobj = obj_bullet
	meleeobj = obj_melee
	ismelee = false
	counter = 30
	weaponLength = sprite_get_bbox_right( spr_weapon ) - sprite_get_xoffset( spr_weapon );
	
function get_inputs()
{
	static lista_id = -1;

    if (lista_id != -1 && ds_exists(lista_id, ds_type_list)) {
        ds_list_destroy(lista_id);
    }
	
	lista_id = ds_list_create()
	
	ds_list_add(lista_id, 0,0,0,0,0,0,0)
	
	return lista_id
	
}

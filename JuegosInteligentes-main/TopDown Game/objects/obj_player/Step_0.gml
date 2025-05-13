// get inputs 

var _inputs = get_inputs()

rightkey = _inputs[|0];
leftkey = _inputs[|1];
upkey = _inputs[|2];
downkey = _inputs[|3];
shootkey = _inputs[|4];
meleekey = _inputs[|5];
runkey = _inputs[|6];

// movimientos del jugador
#region 
	// direccion
	var _horizkey = rightkey - leftkey;
	var _vertkey = downkey - upkey;
	moveDir = point_direction(0, 0, _horizkey, _vertkey);
	
	// velocidad
	if (runkey) 
	{
	var _spd = 0;
	var _inputlevel = point_distance(0, 0, _horizkey, _vertkey);
	_inputlevel = clamp( _inputlevel, 0, 1);
	_spd = (moveSpd + 2) * _inputlevel;
	
	xspd = lengthdir_x(_spd, moveDir);
	yspd = lengthdir_y(_spd, moveDir); 
	}
	
	if !(runkey)
	{
	var _spd = 0;
	var _inputlevel = point_distance(0, 0, _horizkey, _vertkey);
	_inputlevel = clamp( _inputlevel, 0, 1);
	_spd = moveSpd * _inputlevel;
	
	xspd = lengthdir_x(_spd, moveDir);
	yspd = lengthdir_y(_spd, moveDir); 
	}
	
	//colision
	if place_meeting( x + xspd, y, obj_wall)
	{
		xspd =0;
	}
	if place_meeting( x, y + yspd, obj_wall)
	{
		yspd = 0;
	}
	
	// mover al jugador
	x += xspd;
	y += yspd;
	
	depth = -bbox_bottom
#endregion

// apuntando
	centerY = y + centerYOffset; 
	
	//mira
	aimDir = point_direction(x, centerY, mouse_x, mouse_y);

// control de sprites
#region
if (!ismelee){
	face = round(aimDir / 90);
	if face > 3 {face = 0; };
	
	if xspd ==  0 && yspd == 0
	{
		image_index = 0;
	}
	
	if face < 4 {sprite_index = sprite[face];}
}
#endregion

// Diparar
if shootkey && !shield_active
{

	var _xOffset = lengthdir_x( weaponLength + weaponOffsetDist, aimDir);
	var _yOffset = lengthdir_y( weaponLength + weaponOffsetDist, aimDir);
	var _bulletInst = instance_create_depth( x + _xOffset, centerY + _yOffset, depth-100, bulletobj); 
	
	with(_bulletInst)
	{
		owner = other.id
		dir = other.aimDir;
	}
}

if meleekey && not shootkey && !shield_active
{
	ismelee = true
	sprite_index = sprite[face + 4];
	image_index = 0; // Inicia la animación desde el primer cuadro
	counter --
	alarm[0] = counter;
		

	var _xOffset = lengthdir_x( weaponOffsetDist, aimDir);
	var _yOffset = lengthdir_y( weaponOffsetDist, aimDir);
	var _meleeInst = instance_create_depth( x + _xOffset, centerY + _yOffset, depth-100, meleeobj); 
	
	with(_meleeInst)
	{
		dir = other.aimDir;
	}

}

// Escudo 
#region
// Crear el escudo si Shift está presionado y no hay cooldown
if (!shield_active && keyboard_check(vk_shift) && cooldown_timer <= 0) {
    // Crear el escudo
	moveSpd = 0
    var shield_instance = instance_create_layer(x, y, "Instances", obj_shield);
    shield_instance.target = self;          // Asignar al jugador como objetivo
    shield_instance.shield_max_time = 20;   // Configurar duración del escudo
    shield_instance.active = true;          // Activar el escudo

    shield_active = true;
}

// Desactivar escudo al soltar Shift
if (shield_active && !keyboard_check(vk_shift)) {
    // Buscar y destruir el escudo asociado
	moveSpd = 2
    with (obj_shield) {
        if (target == other) {
            instance_destroy();
        }
    }
    shield_active = false;
    cooldown_timer = shield_cooldown_time * 30; // Iniciar cooldown
}

// Reducir cooldown si está en progreso
if (cooldown_timer > 0) {
    cooldown_timer -= 1;
}


#endregion

// recibir daño 
if place_meeting(x, y, obj_demageplayer)
{
	var _inst = instance_place(x, y, obj_demageplayer);
	
	// recibiendo danio de una instancia en especifica
	if (_inst.owner != id) {
	hp -= _inst.demage;
	
	_inst.destroy = true;
	}
}

if place_meeting(x, y, obj_enemyParent) and cooldown_timer == 0
{
	var _inst = instance_place(x, y, obj_enemyParent);
	
	// recibiendo danio de una instancia en especifica
	hp -= _inst.demage;
	cooldown_timer = 60
	
}

if place_meeting(x, y, obj_foodparent)
{
	var _inst = instance_place(x, y, obj_foodparent)
	
	// curandose de una instancia especifica
	hp += _inst.healing
	
	_inst.destroy = true;
}

// reinicial cooldown 
if cooldown_timer > 0
{
	cooldown_timer--
}

// morir
if hp <= 0
{
	instance_destroy()
}




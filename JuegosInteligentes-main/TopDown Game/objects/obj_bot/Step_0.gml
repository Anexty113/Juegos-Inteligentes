// seguir al jugador



spd = 1

var _decision = get_inputs()
//var _decision = 2

// Acciones
if (instance_exists(opponent) && distance <= detection_radius) {

	// Perseguir
	if _decision == 0
	{
		seguir()
	}
	
	//Buscar objeto
	else if _decision == 1
	{
		curarse()
	}
	else if _decision == 2
	{
		huir()
	}
	else if _decision == 3
	{
		ataq_cerca()
	}
	else if _decision == 4
	{
		ataq_lejos()
	}
	else if _decision == 5
	{
		cubrirse()
	}
	
	
} else 
{
	moveSpd = 0
}

	xspd = lengthdir_x(spd, dir)
	yspd = lengthdir_y(spd, dir)

	if xspd ==  0 && yspd == 0
	{
		image_index = 0;
	}

// corregir orientacion
	if xspd > 0 {face = -1}
	else {face = 1}
	image_xscale = face
	

// colisiiones
	if place_meeting(x + xspd, y, obj_wall ) or place_meeting(x + xspd, y, opponent) or place_meeting(x + xspd, y, obj_shield)
	{
		xspd = 0
	}
	
	if place_meeting(x, y + yspd, obj_wall ) or place_meeting(x, y + yspd, opponent ) or place_meeting(x + xspd, y, obj_shield)
	{
		yspd = 0
	}
	
	
	x += xspd
	y += yspd
	


// Inherit the parent event
event_inherited();

if place_meeting(x, y, obj_demageplayer)
{
	var _inst = instance_place(x, y, obj_demageplayer);
	
	//guardando daño de partida
	acum_dmg += _inst.demage
	
	// recibiendo danio de una instancia en especifica
	hp -= _inst.demage;
	
	_inst.destroy = true;
}

if place_meeting(x, y, obj_enemyParent) and cooldown_timer == 0 and !shield_active
{
	var _inst = instance_place(x, y, obj_enemyParent);
	
	//guardando daño de partida
	acum_dmg += _inst.demage
	
	// recibiendo danio de una instancia en especifica
	hp -= _inst.demage;
	cooldown_timer = 60
	
}

// reinicial cooldown 
if cooldown_timer > 0
{
	cooldown_timer--
}

//Actualizar sensores
update_sensor_matrix()

//actualizar rendimiento
update_fitness()

// seguir al jugador

spd = 1

if (instance_exists(opponent)) {
    var dx = opponent.x - x;
    var dy = opponent.y - y;
    var distance = sqrt(dx * dx + dy * dy);

	if (hp > 5 or !instance_exists(obj_foodparent)) && distance >= detection_radius
	{
		mp_potential_step_object(opponent.x, opponent.y, 1, obj_wall)
		dir = point_direction(x, y, opponent.x, opponent.y)
	}
	
	if (hp > 5 or !instance_exists(obj_foodparent)) && distance < detection_radius 
	{
		spd = 0
		
		// atacar
		if cooldownTimer == 0
		{
			var _bulletInst = instance_create_depth( x , y, depth-100, obj_enemybullet); 
			dir = point_direction(x, y, opponent.x, opponent.y)
	
			with(_bulletInst)
			{
				dir = other.dir;
			}
			cooldownTimer = 60
		}
		// reiniciar cooldown 

		if cooldownTimer > 0
		{
			cooldownTimer --
		}
	}
	
	if instance_exists( obj_foodparent) && hp <= 5
	{
		mp_potential_step_object(obj_foodparent.x, obj_foodparent.y, 1, obj_wall)
		dir = point_direction(x, y, obj_foodparent.x, obj_foodparent.y)
	}
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
	if place_meeting(x + xspd, y, obj_wall ) or place_meeting(x + xspd, y, obj_enemyParent) or place_meeting(x + xspd, y, obj_shield)
	{
		xspd = 0
	}
	
	if place_meeting(x, y + yspd, obj_wall ) or place_meeting(x, y + yspd, obj_enemyParent ) or place_meeting(x + xspd, y, obj_shield)
	{
		yspd = 0
	}
	
	
	x += xspd
	y += yspd

// heredar

event_inherited();


function draw_weapon(){
	// Corregir direccion de la pitola
	var _weaponYscl = 1;
	if aimDir > 90 && aimDir < 270
	{
		_weaponYscl = -1;
	}

	draw_sprite_ext( spr_weapon, 0, x, centerY, 1, _weaponYscl, aimDir, c_white, 1 );
}

function melee(){
	// Corregir direccion del golpe
	var _meleeYscl = 1;
	if aimDir > 90 && aimDir < 270
	{
		_meleeYscl = -1;
	}

	draw_sprite_ext( spr_weapon, 0, x, centerY, 1, _weaponYscl, aimDir, c_white, 1 );
}


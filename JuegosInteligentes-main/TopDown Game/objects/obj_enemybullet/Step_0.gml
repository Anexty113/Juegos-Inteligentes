xspd = lengthdir_x( spd, dir );
yspd = lengthdir_y( spd, dir );

x += xspd;
y += yspd;

if place_meeting(x, y, obj_solidwall)
{
	destroy = true;
}


if place_meeting(x, y, obj_shield)
{
	wait --
}
if wait < 1 
{
destroy = true;
}

if point_distance( xstart, ystart, x, y ) > maxDist
{
	destroy = true; 
}

if destroy ==true {
	instance_destroy(); }
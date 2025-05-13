time += 1;
xspd = lengthdir_x( 1, 270);
yspd = lengthdir_y( 1, 270);

x += xspd;
y += yspd;


if time > maxTime
{
	destroy = true;
}


if destroy == true
{
	instance_destroy();
}
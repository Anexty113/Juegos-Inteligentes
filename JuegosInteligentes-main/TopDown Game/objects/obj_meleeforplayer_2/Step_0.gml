time += 1;
xspd = lengthdir_x( 1, 180);
yspd = lengthdir_y( 1, 180);

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
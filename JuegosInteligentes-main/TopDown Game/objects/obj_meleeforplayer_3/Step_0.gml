time += 1;
xspd = lengthdir_x( 1, 90);
yspd = lengthdir_y( 1, 90);

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
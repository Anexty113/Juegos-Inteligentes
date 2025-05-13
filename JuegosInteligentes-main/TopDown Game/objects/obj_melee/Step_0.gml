time += 1;
xspd = lengthdir_x( 1, dir );
yspd = lengthdir_y( 1, dir );

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
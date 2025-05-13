if instance_exists(follow)
{
	xTo = follow.x 
	yTo = follow.y 
}
else
{
	follow = obj_enemyParent
}

x += (xTo - x) / 25
y += (yTo - y) / 25

camera_set_view_pos(view_camera[0], x -(camWidth*0.5), y-(camHeight*0.5))

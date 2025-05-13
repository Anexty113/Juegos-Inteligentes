// recibir danio
if place_meeting(x, y, obj_demageenemy) {
    var _inst = instance_place(x, y, obj_demageenemy);
    
    // Comprobar si el owner de la instancia es diferente al id propio
    if (_inst.owner != id) {
        // Guardando daño de partida
        acum_dmg += _inst.demage;

        // Recibiendo daño de una instancia en específica
        hp -= _inst.demage;

        // Destruir la instancia de obj_demageenemy
        _inst.destroy = true;
    }
}


if place_meeting(x, y, obj_foodparent)
{
	var _inst = instance_place(x, y, obj_foodparent)
	
	// curandose de una instancia especifica
	hp += _inst.healing
	
	_inst.destroy = true;
}



// morir
if hp <= 0
{
	instance_destroy()
}
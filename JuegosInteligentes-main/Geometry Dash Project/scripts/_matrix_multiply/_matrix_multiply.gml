// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function _matrix_multiply(a, b){
    var am, an, bm, bn;
    am = array_length(a);         // Número de filas de 'a'
    an = array_length(a[0]);      // Número de columnas de 'a'
    bm = array_length(b);         // Número de filas de 'b'
    bn = array_length(b[0]);      // Número de columnas de 'b'
    
    // Verificar si las matrices no son vacías
    if (am == 0 || an == 0 || bm == 0 || bn == 0) {
        return undefined;
    }
    
    // Verificar compatibilidad de dimensiones para multiplicación
    if (an != bm) {
        return undefined;
    }
	
	if ((am == 1) && (bn == 1))
	{
	var tot = 0
	for (var i = 0; i < an; i++)
		tot += a[0][i]*b[i][0];
	return [[tot]]
	} else if (am == 1)
	{
		var vec = array_create(bn, 0)
		for (var j = 0; j < bn; j++)
		{
			for (var i = 0; i < bm ; i++)
			vec[j] += a[0][i]*b[i][j]
		}
		return [vec]
	}
	else if (bn==1)
	{
		var vec = array_create(am, 0)
		for (var i = 0; i < am; i++)
		{
			for (var j = 0; j < an; j++)
				vec[i] += a[i][j]*b[j][0]
		}
		return [vec]
	}
	else 
	{
		var mat = array_create(am, array_create(bn))
		for (var i = 0; i < am; i++)
		{
			for (var j = 0; j < bn ; j++)
			{
				mat[i][j] = 0
				for (var k=0; k<an;k++)
				mat[i][j] += a[i][k]*b[k][j]
			}
		}
		return [mat]
	}
    
   
}
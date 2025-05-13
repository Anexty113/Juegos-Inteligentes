// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function mutate_matrix(_matrix, _prob, _offset){
	var _minv = _offset*-1
	var _maxv = _offset
	var n_rows = array_length(_matrix)
	var n_cols = array_length(_matrix[0])
	
	var _new_matrix = array_create(n_rows)
	
	for (var _i = 0; _i < n_rows; _i++)
	{
		_new_matrix[_i] = array_create(n_cols)
		for (var _j = 0; _j < n_cols; _j++)
		{
			var _value = _matrix[_i][_j]
		if (random(100) < _prob){
			_value += random_range(_minv, _maxv);
			
		}
		_new_matrix[_i][_j] = _value
		}
	}
	return _new_matrix
}
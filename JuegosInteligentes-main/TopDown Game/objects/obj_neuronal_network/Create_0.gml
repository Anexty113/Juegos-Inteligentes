n_inputs = 5
n_outputs = 5
n_hidden = 0

//Capa 1
w1 = create_random_matrix(n_outputs, n_inputs,-1,1)
b1 = create_random_matrix(1, n_outputs,-1,1)

//Capa 2
//w2 = create_random_matrix(1, n_outputs,-1,1)
//b2 = create_random_matrix(1, 1,-1,1)


// Toda la red
w = [w1]
b = [b1]

//var _x = create_random_matrix(n_inputs,1,-1,1)
//show_debug_message(string(w[0]))
//show_debug_message(string(_x))
//show_debug_message(string(b[0]))
//show_debug_message(string(_matrix_transpose(_matrix_multiply(w1,_x))))
//show_debug_message(string(_matrix_sum(_matrix_multiply(w1,_x), b1)))



function evaluate(_x)
{
	//show_debug_message("w = "+ string(w))
	show_debug_message("x = "+string(_x))
	//show_debug_message("multiply = "+string(_matrix_multiply(w,_x)))
	var _capa1 = _matrix_sum( _matrix_multiply(w[0], _x), b[0] )
	//var _capa2 = _matrix_sum( _matrix_multiply(w[1], _matrix_transpose(_capa1)), b[1] )
	
	return _capa1
}
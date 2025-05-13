// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function _matrix_transpose(matrix){
    var rows = array_length(matrix);
    if (rows == 0) {
        return [];
    }
    var cols = array_length(matrix[0]);
    
    var transposed = array_create(cols);
    for (var _i = 0; _i < cols; _i++){
        var _row = array_create(rows);
        for (var _j = 0; _j < rows; _j++){
            _row[_j] = matrix[_j][_i];
        }
        transposed[_i] = _row;
    }
    return transposed;
}

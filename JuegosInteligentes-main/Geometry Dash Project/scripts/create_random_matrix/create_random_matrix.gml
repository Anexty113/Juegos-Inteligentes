function create_random_matrix(nRows, nCols, minValue, maxValue){
    
    var _matrix = array_create(nRows);
    for (var _i = 0; _i < nRows; _i++){
        var _row = array_create(nCols);
        for (var _j = 0; _j < nCols; _j++){
            _row[_j] = random_range(minValue, maxValue);
        }
        _matrix[_i] = _row;
    }
    return _matrix;
}

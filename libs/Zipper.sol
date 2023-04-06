// SPDX-License-Identifier: MIT
// created by arielrobotti@gmail.com
pragma solidity >=0.8.2 <0.9.0;
/*Esta libreria sirve para comprimir arrays de N enteros de 8 bits con un factor de compresion
de 32, mas 1 uint256 con el que se indicará el tamaño del arreglo original.
por ejemplo un array de 1000 uint256 quedara comprimido en un array de 1000/32 +1 uint256
*/
library Zipper{
    
    function zip(uint256[] memory _values) public pure returns(uint256[] memory){
        uint256 len = _values.length;
        uint256[] memory result = new uint256[](len/32 + (len % 32 != 0 ? 1 : 0) + 1);
        result[0] =len;
        uint256 currentCluster;
        for(uint i=0; i<len; i++){
            require(_values[i]<256, "Datos de entrada invalidos");
            if (i != 0  && i%32 == 0){
                result[i/32] = currentCluster;
                currentCluster = 0| (_values[i] & 255);
            }
            else{
                currentCluster |= (_values[i] & 255) << (i%32*8);
            }      
        }
        if(len%32 != 0){
           currentCluster = 0;
           for (uint i=0; i<len%32; i++){
               currentCluster |= (_values[len-len%32+1] & 255) << (i%32*8);
           }
           result[len/32 +1] = currentCluster;
        }
        return result;
    }
    function readPosition(uint256[] memory _data, uint256 _pos) public pure returns(uint256){
        require(_pos < _data[0], "Posicion fuera de rango");
        return _data[_pos/32+1] >> (_pos % 32 *8) & 255;
    }
    function writePosition(uint256[] storage _data, uint256 _value, uint256 _pos) public{
        require(_pos<_data[0], "Posicion fuera de rango");
        require(_value<256, "Valor no permitido (0-255)");      
        _data[_pos/32+1] |= 255 <<  (_pos % 32 *8);
        _data[_pos/32+1] &= (_value & 255) << (_pos % 32 *8);
    }
}
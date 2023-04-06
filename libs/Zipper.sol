// SPDX-License-Identifier: MIT
// created by arielrobotti@gmail.com
// at address - 0x3459e0368AaD228ff0A4198F4e78F9EC29ac914f
// Version corregida - 0x5FDd55f8273c09833e7b32583113D6f4c455191b
// Validacion de array - 0x68b7136F4b507dBDe03ddC1429ac58275ab5a257
pragma solidity >=0.8.2 <0.9.0;
library Zipper{

    function zip(uint256[] memory _values) public pure returns(uint256[] memory){
        uint256 len = _values.length;
        uint256[] memory result = new uint256[](len/32 + (len % 32 != 0 ? 1 : 0) + 1);
        uint256 firma = 97114105101108114111098111116116105064103109097105108046099111109;

        uint256 currentCluster = len;   //Introducir una firma de verificacion dentro de esta variable
                                        //para evitar que se puedan manipular uint256[] que no son 
                                        //arrays comprimidos por esta libreria
        currentCluster |= firma << 32;

        for(uint i=0; i<len; i++){
            require(_values[i]<256, "Datos de entrada invalidos");
            if (i%32 == 0){
                result[i/32] = currentCluster;
                currentCluster = 0| (_values[i] & 255);
            }
            else currentCluster |= (_values[i] & 255) << (i%32*8);     
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
        require(_data[0] >> 32 == 97114105101108114111098111116116105064103109097105108046099111109,
                "Array incompatible");
        require(_pos < _data[0] & 4294967295, "Posicion fuera de rango");
        
        return _data[_pos/32+1] >> (_pos % 32 *8) & 255;
    }
    function writePosition(uint256[] storage _data, uint256 _value, uint256 _pos) public{
        require(_data[0] >> 32 == 97114105101108114111098111116116105064103109097105108046099111109,
                "Array incompatible");
        require(_pos<_data[0], "Posicion fuera de rango");
        require(_value<256, "Valor no permitido (0-255)");      
        _data[_pos/32+1] &= ~(255 <<  (_pos % 32 *8)); //Ponemos a cero los 8 bits correspondientes
        _data[_pos/32+1] |= _value << (_pos % 32 *8);  //Introducimos el _value en esos 8 bits
    }
    function lenUnzipped(uint256[] storage _data)public view returns(uint256){
         require(_data[0] >> 32 == 97114105101108114111098111116116105064103109097105108046099111109,
                "Array incompatible");
        return _data[0] & 4294967295; 
    }
}
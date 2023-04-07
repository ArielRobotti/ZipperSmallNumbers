// SPDX-License-Identifier: GPL-3.0
// at address - 0xD8cA28F015a89AB556698Ec17CB404964dB10c30
// Version Corregida - 0x274eCF451605F1c26DEC114F4BCBFD780c623bDa
// Validación de entrada - 0x65d82fcF2492676a8B4D5EC1D9c39a0c50DF0eCB
pragma solidity >=0.8.2 <0.9.0;
import "../libs/Zipper.sol";

contract Test {
    using Zipper for uint256[];
    uint256[] private compArray;
    uint256[] private arrayNoComprimido = [0,1,2,3,4,5,6];

    function compress(uint256[] memory _in) public {
        compArray = _in.zip();
    }
    function len() public view returns(uint256, uint256){
        return (compArray.lenUnzipped(), compArray.length);
    }
    function getPosition(uint256 _pos) public view returns (uint256) {
        return compArray.readPosition(_pos);
    }
    function setPosition(uint256 _pos, uint256 _value) public {
        compArray.writePosition(_value, _pos);
    }
    function testValidate()public view{
        arrayNoComprimido.readPosition(0);
    }

}
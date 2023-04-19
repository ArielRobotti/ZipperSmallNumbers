// SPDX-License-Identifier: GPL-3.0

//Deploy Adress - 0x706883a860D40DfD268138eDF008D9D3cd235b97 Mumbai
//Deploy gas: 0.00224397 (library) + 0.00171945 (test)
/*
Input example:
[0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,
 0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,
 0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,
 0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9]
 */
//0.00133546 MATIC setCompArray()
//0.00884402 MATIC setNormalArray()
//0.00012905 MATIC setPositionCompArray()
//0.00007285 MATIC setPositionArray()

pragma solidity >=0.8.2 <0.9.0;
import "../libs/Zipper.sol";

contract Test {
    using Zipper for uint256[];
    uint256[] public compArray;
    uint256[] public arrayNormal;
 
    function lenCompArray() public view returns(uint256){
        return compArray.length;
    }
    function lenNormalArray() public view returns(uint256){
        return arrayNormal.length;
    }
    function getPosition(uint256 _pos) public view returns (uint256) {
        return compArray.readPosition(_pos);
    }
    function setPositionCompArray(uint256 _pos, uint256 _value) public {
        compArray.writePosition(_value, _pos);
    }
    function testValidate()public view{
        arrayNormal.readPosition(0);
    }
    function saveNormalArray(uint256[] memory _data)public{
        arrayNormal = _data;
    }
    function saveCompArray(uint256[] memory _data)public{
        compArray = _data.zip();
    }

    function setPositionNormalArray(uint256 _pos,uint256 _value)public {
        arrayNormal[_pos] = _value;
    }
}
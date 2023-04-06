// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;
import "../libs/Zipper.sol";

contract Test {
    using Zipper for uint256[];
    uint256[] private compArray;

    function compress(uint256[] memory _in) public {
        compArray = _in.zip();
    }
    function len() public view returns(uint256, uint256){
        return (compArray[0], compArray.length);
    }
    function getPosition(uint256 _pos) public view returns (uint256) {
        return compArray.readPosition(_pos);
    }
    function setPosition(uint256 _pos, uint256 _value) public {
        compArray.writePosition(_value, _pos);
    }
}
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


// NFT: Adress
// 0x88b48f654c30e99bc2e4a1559b4dcf1ad93fa656

contract Caller {
    function someAction(address addr) public returns(uint) {
        Callee c = Callee(addr);
        return c.getValue(100);
    }
    
    function storeAction(address addr) public returns(uint) {
        Callee c = Callee(addr);
        c.storeValue(100);
        return c.getValues();
    }
    
    function callAdr(address addr) public {
        Callee(addr).storeValue{gas:1}(1);

    }
}


abstract contract Callee {
    function  getValue(uint initialValue) public virtual returns(uint);
    function storeValue(uint value) public virtual;
    function getValues() public virtual returns(uint) ;
}

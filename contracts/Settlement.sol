// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


// NFT: Adress
// 0x88b48f654c30e99bc2e4a1559b4dcf1ad93fa656

contract Settlement {
    
    address payable[] recipients;
    function triggerSettlement(address payable recipient) external  {
        recipient.send(0.0001 ether);
    }
    
}


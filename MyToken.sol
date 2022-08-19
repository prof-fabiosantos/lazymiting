// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyToken is ERC721, Ownable {

    using Counters for Counters.Counter;
     Counters.Counter private _tokenIdCounter;
     uint internal MAX_TOKENS = 100;
     uint internal MAX_TOKENS_PER_SALE = 10;
     uint internal PRICE = 1;
     
     bool internal isSaleActive = true;


    constructor() ERC721("MyToken", "MTK") {}

    function safeMint(uint256 _amount) public payable {

        require(isSaleActive, "Sale is currently not active");
        require(MAX_TOKENS > _amount + _tokenIdCounter.current() + 1, "Not enough tokens left to buy.");
        require(_amount > 0 && _amount < MAX_TOKENS_PER_SALE + 1, "Amount of tokens exceeds amount of tokens you can purchase in a single purchase.");
        require(msg.value >= PRICE * _amount, "Amount of ether sent not correct.");

        for(uint256 i = 0; i < _amount; i++){
            _safeMint(msg.sender, _tokenIdCounter.current());
            _tokenIdCounter.increment();
        }
    }       

}
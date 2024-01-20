// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Auction {    
    // Define data structures for Items and Persons
    struct Item {
        uint itemId; // Unique identifier for the item
        uint[] itemTokens; // Array holding tokens bid for the item
    }
    
    struct Person {
        uint remainingTokens; // Number of tokens remaining with the bidder
        uint personId; // Serves as unique identifier for the bidder
        address addr; // Address of the bidder
    }

    // Map to associate addresses with Person objects
    mapping(address => Person) tokenDetails; 

    // Array of Person objects representing registered bidders
    Person [4] bidders; 

    // Array of Item objects representing auction items
    Item [3] public items;

    // Array of addresses representing the winners of the auction
    address[3] public winners;

    // Address of the owner of the smart contract
    address public beneficiary;

    // Counter for keeping track of the number of registered bidders
    uint bidderCount=0;

    // Constructor function to initialize the contract
    constructor() payable{    
        // Set the beneficiary as the owner of the contract
        beneficiary = msg.sender;

        // Initialize the items array with 3 empty items
        uint[] memory emptyArray;
        items[0] = Item({itemId:0,itemTokens:emptyArray});
        items[1] = Item({itemId:1,itemTokens:emptyArray});
        items[2] = Item({itemId:2,itemTokens:emptyArray});
    }

    // Function to register a new bidder
    function register() public payable{
        // Set the personId of the new bidder
        bidders[bidderCount].personId = bidderCount;

        // Set the address of the new bidder
        bidders[bidderCount].addr = msg.sender;

        // Set the initial number of tokens for the new bidder
        bidders[bidderCount].remainingTokens = 5;

        // Update the tokenDetails map with the new bidder
        tokenDetails[msg.sender]=bidders[bidderCount];

        // Increment the counter for the number of registered bidders
        bidderCount++;
    }

    // Function to place a bid on an item
    function bid(uint _itemId, uint _count) public payable{
        // Check if the bidder has enough tokens
        require(tokenDetails[msg.sender].remainingTokens >= _count);

        // Check if the bidder has any tokens left
        require(tokenDetails[msg.sender].remainingTokens > 0);

        // Check if the itemId is valid
        require(_itemId <= 2);

        // Decrease the number of tokens of the bidder
        uint balance= tokenDetails[msg.sender].remainingTokens - _count;
        tokenDetails[msg.sender].remainingTokens=balance;
        bidders[tokenDetails[msg.sender].personId].remainingTokens=balance;

        // Add the bidder's tokens to the item
        Item storage bidItem = items[_itemId];
        for(uint i=0; i<_count;i++) {
            bidItem.itemTokens.push(tokenDetails[msg.sender].personId);    
        }
    }

    // Modifier to restrict access to the revealWinners function to the owner of the contract
    modifier onlyOwner {
        require(msg.sender == beneficiary);
        _;
    }

    // Function to reveal the winners of the auction
    function revealWinners() public onlyOwner{
        // Iterate over all the items
        for (uint id = 0; id < 3; id++) {
            Item storage currentItem=items[id];
            // If at least one person has placed a bid
            if(currentItem.itemTokens.length != 0){
                // Generate a random index based on the block number
                uint randomIndex = (block.number / currentItem.itemTokens.length)% currentItem.itemTokens.length; 
                // Get the winner's tokenId
                uint winnerId = currentItem.itemTokens[randomIndex];
                // Assign the winner's address to the winners array
                winners[id] = bidders[winnerId].addr;
            }
        }
    } 

    // Function to retrieve the details of a bidder
    function getPersonDetails(uint id) public view returns(uint,uint,address){
        return (bidders[id].remainingTokens,bidders[id].personId,bidders[id].addr);
    }
}

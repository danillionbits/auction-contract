#Chinese Auction Smart Contract
This repository contains the implementation of a Chinese auction smart contract in Solidity. The smart contract allows users to participate in token-based auctions on the Ethereum blockchain.

##Contract Structure
The smart contract is structured using four primary data structures:

1. **Item**: Encapsulates information about an auction item, including its unique identifier and the tokens bid for the item.

2. **Person**: Stores details about each bidder, including their remaining tokens, person ID, and Ethereum address.

3. **tokenDetails**: A mapping that associates Ethereum addresses with corresponding Person objects.

4. **bidders**: An array that holds Person objects representing registered bidders.

##Contract Functionality
The smart contract provides three main functionalities:

1. **Registration**: Allows users to register as bidders, assigning a unique person ID and an initial token balance of 5 tokens.

2. **Bidding**: Enables registered bidders to place bids on auction items, specifying the number of tokens they are willing to commit.

3. **Revealing Winners**: Determines the winners of each auction item by randomly selecting a token ID from the item's token list. The corresponding bidder's address is stored in the winners array.

##Testing
To ensure the contract's functionality, testing is crucial. The Remix JavaScript VM provides a suitable environment for testing the smart contract. Here's a step-by-step guide:

1. Compile and deploy the contract to the Remix VM.

2. Register four bidders using the "register" function.

3. Place bids for each item using the "bid" function.

4. Execute the "revealWinners" function to randomly determine the winners for each item.

5. Retrieve the winners' addresses using the "winners" getter.

##Reference
For a more detailed explanation of the smart contract implementation, please refer to the following Medium article:

[Medium Article Source](https://medium.com/coinmonks/building-a-chinese-auction-smart-contract-with-solidity-and-remix-ide-8b242fbcaf3b)

##Contributing
Contributions are welcome! Please feel free to open an issue or submit a pull request for any changes or improvements.

##Changelog
- v1.0.0: Initial release

##License
MIT License
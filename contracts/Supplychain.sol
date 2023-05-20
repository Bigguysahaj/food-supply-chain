// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Supplychain {
    struct Item {
        address itemId;
        string name;
        uint256 expirationDate;
        uint256 quantity;
        address owner;
        string[] nutrient;
        bool isEmpty;
    }

    mapping(address => Item) public items;
    uint256 public itemCount;

    event ItemAdded(address itemId, string name, uint256 expirationDate, uint256 quantity, address owner, string[] nutrient);
    event ItemUpdated(address itemId, string name, uint256 expirationDate, uint256 quantity, address owner, string[] nutrient);
    event ItemClaimed(address itemId, address claimer);

    function addItem(address _itemId, string memory _name, uint256 _expirationDate, uint256 _quantity, string[] memory _nutrient) public {
        require(items[_itemId].itemId == address(0), "Item with the same ID already exists");
        itemCount++;
        items[_itemId] = Item(_itemId, _name, _expirationDate, _quantity, msg.sender, _nutrient, false);
        emit ItemAdded(
            _itemId,
            _name,
            _expirationDate, 
            _quantity, 
            msg.sender, 
            _nutrient
        );
    }

    function updateItem(address _itemId, string memory _name, uint256 _expirationDate, uint256 _quantity, string[] memory _nutrient) public {
        Item storage item = items[_itemId];
        require(msg.sender == item.owner, "Only item owner can update");
        item.name = _name;
        item.expirationDate = _expirationDate;
        item.quantity = _quantity;
        item.nutrient = _nutrient;
        emit ItemUpdated(_itemId, _name, _expirationDate, _quantity, msg.sender, _nutrient);
    }

    function claimItem(address _itemId) public {
        Item storage item = items[_itemId];
        require(item.expirationDate > block.timestamp, "Item has expired");
        require(item.quantity > 0, "Item is out of stock");
        item.quantity--;
        emit ItemClaimed(_itemId, msg.sender);
    }

    function getCurrentInventoryCount() public view returns (uint256) {
        uint256 count;
        for (uint256 i = 1; i <= itemCount; i++) {
            if (!items[i].isEmpty) {
                count += items[i].quantity;
            }
        }
        return count;
    }
}

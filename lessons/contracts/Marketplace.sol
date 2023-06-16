// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Marketplace {
    string public name;

    struct Product {
        uint id;
        string name;
        uint price;
        address owner;
        bool purchased;
    }

    mapping(uint => Product) public products;
    uint public productCount;

    event ProductCreated(
        uint id,
        string name,
        uint price,
        address owner,
        bool purchased
    );

    event ProductPurchased(
        uint id,
        string name,
        uint price,
        address owner,
        bool purchased,
        bytes wereyy
    );

    constructor() {
        name = "Playing with Truffle";
    }

    modifier validCreateProductParams(string memory _name, uint _price) {
        require(
            bytes(_name).length > 0,
            "This value cannot be an empty string!"
        );
        require(_price > 0, "Price must be greater than 0");
        _;
    }

    function createProduct(
        string memory _name,
        uint _price
    ) public validCreateProductParams(_name, _price) {
        // validate parameters
        // increment product count
        productCount++;
        // create product
        products[productCount] = Product(
            productCount,
            _name,
            _price,
            msg.sender,
            false
        );
        // trigger an event
        emit ProductCreated(productCount, _name, _price, msg.sender, false);
    }

    function purchaseProduct(uint _id) public payable {
        // make sure the product has a valid id
        require(_id < productCount, "Product with provided _id does not exist!");
        // fetch the _product
        Product storage _product = products[_id];
        // check: _product is valid, can be purchased
        require(!_product.purchased, "This product has been sold");
        // check: sender sent correct amount for _product price
        require(
            msg.value >= _product.price,
            "Provided ETH amount is not enough! Send more ETH"
        );
        // fetch the owner
        address _seller = _product.owner;
        // purchase product and transfer ownership
        (bool success, bytes memory wereyy) = payable(_seller).call{
            value: msg.value
        }("");
        require(success, "Could not complete purchase! Please try again");

        _product.owner = msg.sender;
        // update the product
        _product.purchased = true;
        products[_id] = _product;
        // trigger an event
        emit ProductPurchased(
            productCount,
            _product.name,
            _product.price,
            _product.owner,
            _product.purchased,
            wereyy
        );
    }
}

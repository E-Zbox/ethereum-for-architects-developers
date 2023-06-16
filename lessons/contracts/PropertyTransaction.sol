// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library StringsCanByte {
    function bytes32ToString(
        bytes32 _bytes32
    ) private pure returns (string memory) {
        return string(abi.encodePacked(_bytes32));
    }

    function toString(bytes32 _bytes32) internal returns (string memory) {
        return bytes32ToString(_bytes32);
    }
}

contract PropertyTransaction {
    using StringsCanByte for bytes32;
    // landRegistryAdmin - is the user that initiated the contract
    address landRegistryAdmin;
    /**
        this contract is a basic land registry program where only the contract initiator
        can assign properties to people after some document verification
     */
    struct Property {
        // each property has a unique propertyId
        uint propertyId;
        // property ownership is a historical data that has a seller, an owner/buyer and a date of transaction
        bytes32[] ownershipHistory;
    }

    // registered properties
    Property[] properties;

    /**
        PropertySold is an event that informs on success or failure of a transaction
     */
    event PropertySold(
        uint propertyId,
        string ownership,
        bool flag,
        string message
    );

    constructor() {
        // initiate the landRegistryAdmin as the contract creator and initiate some registered properties
        landRegistryAdmin = msg.sender;

        Property memory property0 = Property(0, new bytes32[](0));
        properties.push(property0);
        properties[properties.length - 1].ownershipHistory.push(
            "Buyer:b0, Seller:s0, DOT:dt0"
        );

        Property memory property1 = Property(1, new bytes32[](0));
        properties.push(property1);
        properties[properties.length - 1].ownershipHistory.push(
            "Buyer:b1, Seller:s1, DOT:dt1"
        );

        Property memory property2 = Property(2, new bytes32[](0));
        properties.push(property2);
        properties[properties.length - 1].ownershipHistory.push(
            "Buyer:b2, Seller:s2, DOT:dt2"
        );
    }

    /**
        Land registration authority may alter ownership to any of the exisiting properties
    */
    function addNewOwner(uint propertyId, bytes32 ownership) public {
        if (msg.sender != landRegistryAdmin) {
            emit PropertySold(
                propertyId,
                ownership.toString(),
                false,
                "Only land registry department can assign ownership to buyer"
            );
        }

        for (uint i = 0; i < properties.length; i++) {
            if (properties[i].propertyId == propertyId) {
                properties[i].ownershipHistory.push(ownership);
                emit PropertySold(
                    propertyId,
                    ownership.toString(),
                    true,
                    "New ownership added to existing property"
                );
                break;
            }
        }

        // propertyId does not exist in record, hence create a new transaction and add to registered properties
        Property memory property = Property(
            properties.length,
            new bytes32[](0)
        );
        properties.push(property);
        properties[properties.length - 1].ownershipHistory.push(ownership);
        emit PropertySold(
            propertyId,
            ownership.toString(),
            true,
            "New Property added"
        );
    }

    function retrievePropertyHistory(
        uint propertyId
    ) public view returns (bytes32[] memory ownership) {
        for (uint i = 0; i < properties.length; i++) {
            if (properties[i].propertyId == propertyId) {
                return properties[i].ownershipHistory;
            }
        }
    }
}

pragma solidity ^0.4.23;

import "./strings.sol"; //comment out for testing in remix
//import "github.com/Arachnid/solidity-stringutils/strings.sol"; //uncomment for testing in remix

contract SmartFoodDelivery {
    using strings for *;
    address foodCompany;
    mapping(address => uint) orderCounter;
    OrderItem[] public orders;
    
    struct OrderItem {
        uint orderId;
        address customer;
    }
    
    struct FoodItem {
        string description;
        uint orderId;
        bool isPreparedDeliveryStarted;
        bool isDeliveredandPaid;
        bool isCancelled;
        address customer;
    }

    mapping(address => FoodItem[]) public fooditems;

    function SmartFoodDelivery() {
        foodCompany = msg.sender;
    }

    function placeMyOrder(string description) public {
        FoodItem memory newOrderItem = FoodItem({
            description: description,
            orderId: orderCounter[msg.sender],
            isPreparedDeliveryStarted: false,
            isDeliveredandPaid: false,
            isCancelled: false,
            customer: msg.sender
        });
        
        fooditems[msg.sender].push(newOrderItem);
       
        
        OrderItem memory newOrder = OrderItem({
            orderId: orderCounter[msg.sender],
            customer: msg.sender
        });
        orders.push(newOrder);
        
        orderCounter[msg.sender]++;
    }
    
    function returnMyLastOrderNumber() public view returns (string) {
        uint allOrders = fooditems[msg.sender].length;
        if (allOrders == 0) {
            return "You have not placed an order yet.";
        }
        return "Order number for your last order is ".toSlice().concat(uint2str(fooditems[msg.sender][allOrders-1].orderId).toSlice());
    }

    function signMyDeliverdOrder(uint orderNumber) public {
        if (fooditems[msg.sender][orderNumber].isPreparedDeliveryStarted==true) {
            fooditems[msg.sender][orderNumber].isDeliveredandPaid = true;
        }
        else revert();
    }
    
    function cancelMyOrder(uint orderNumber) public {
        if (fooditems[msg.sender][orderNumber].isPreparedDeliveryStarted==false) {
            fooditems[msg.sender][orderNumber].isCancelled = true;
        }
        else revert();
    }

    function startDelivery(address customer, uint orderNumber) public {
        if (msg.sender==foodCompany && fooditems[customer][orderNumber].isCancelled==false) {
            fooditems[customer][orderNumber].isPreparedDeliveryStarted = true;
        }
        else revert();
    }

    function uint2str(uint i) internal pure returns (string){
        
        if (i == 0) return "0";
        i = i-1;
        uint j = i;
        uint length;
        while (j != 0){
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint k = length - 1;
        while (i != 0){
            bstr[k--] = byte(48 + i % 10);
            i /= 10;
        }
        return string(bstr);
    }
   
}
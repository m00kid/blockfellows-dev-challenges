Bi-Weekly Dev Challenge 1

TASK 1

Your dapp should have the following functions:

1. A smart contract function to place an order for a food item.

    Assume the foodcompany deploys the contract. The customer is able to place an order providing the description of the order item in the method call:

- SmartFoodDelivery.at('0x130fe2f1627a3e605b2f726617eb23a109968d72').placeMyOrder('burger')
then to fetch the ordernumber use SmartFoodDelivery.at('0x130fe2f1627a3e605b2f726617eb23a109968d72').returnMyLastOrderNumber()

2. A smart contract function to notify that the food has been prepared and delivery has started.
    
    The food company is able to change to order status to 'deilvery started' with the customer addres and order number, all order number and customers adresses are available in the public orders array which is how the food company has a record of all orders. For order details the food company does a lookup in the foodItems array supplying customer address + order id.

- SmartFoodDelivery.at('0x130fe2f1627a3e605b2f726617eb23a109968d72').startDelivery('0x13d15a381ed3f8a9b9949fac7dad87292a02b835',0)

3. A smart contract function to confirm the exchange of money for the food delivery, signifying the end of the event.

    The customer signs the contract once goods have been deliverd and the money exchanged. A simplified exchange of goods for money is assumed, where goods and money can only be exchanged simultaneously.

- SmartFoodDelivery.at('0x130fe2f1627a3e605b2f726617eb23a109968d72').signMyDeliverdOrder(0)

4. A user can cancel the order before it is sent out on delivery.

- SmartFoodDelivery.at('0x130fe2f1627a3e605b2f726617eb23a109968d72').cancelMyOrder(0)


TASK 2

One potential way (not actually tested) to attack the platform would be to 1) place an order 2) wait for the foodcompany to deliver the order 3) at that time place so many new orders such that an overflow occurs in the ordercounter (it is op type uint256, so it will take a while to reach this) untill you reach the id of your order in delivery 4) place a new order which will overwrite the old order but now take a very low priced item 5) sign off on the new order whilst receiving the old order.
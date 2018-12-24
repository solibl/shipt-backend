SELECT U.id, U.first_name, C.id, C.name, OP.number_of_purchased
FROM Orders AS O
JOIN Users AS U ON  O.user_id = U.id
JOIN Products AS P ON P.id = U.id
JOIN Categories AS C ON P.id = C.id
JOIN Order_Products AS OP ON OP.order_id = O.id
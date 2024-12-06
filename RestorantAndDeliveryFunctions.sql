SELECT Name, Price 
FROM Foods 
WHERE Price < 15   -- Prvi upit

SELECT OrdersId, TotalAmount, OrderDate 
FROM Orders 
WHERE TotalAmount > 50 AND EXTRACT(YEAR FROM OrderDate) = 2023      -- Drugi upit

SELECT Name, SuccessfulDeliveries
FROM Staff
WHERE Roles = 'Dostavljac' AND SuccessfulDeliveries > 100    --Treci upit

SELECT s.Name AS StaffName, r.Name AS RestaurantName
FROM Staff s
JOIN Restaurants r ON s.RestaurantId = r.RestaurantId
WHERE s.Roles = 'Kuhar'
AND r.City = 'Zagreb'		--Cetvrti upit

SELECT r.Name AS RestaurantName, COUNT(o.OrdersId) AS OrderCount
FROM Restaurants r
JOIN Orders o ON r.RestaurantId = o.RestaurantId
WHERE r.City = 'Split'
AND EXTRACT(YEAR FROM o.OrderDate) = 2023
GROUP BY r.Name			-- Peti upit 

SELECT f.Name, SUM(oi.Quantity) AS UkupnoPorcija
FROM OrderItems oi
JOIN Foods f ON oi.FoodId = f.FoodId
JOIN Orders o ON oi.OrderId = o.OrdersId
WHERE f.Category = 'Desert'
AND o.OrderDate BETWEEN '2023-12-01' AND '2023-12-31'
GROUP BY f.FoodId
HAVING SUM(oi.Quantity) > 10		--Sesti upit 

SELECT Users.FirstName, Users.LastName, COUNT(Orders.OrdersId) AS OrderCount
FROM Orders
JOIN Users ON Orders.UserId = Users.UserId
WHERE Users.LastName LIKE 'M%'
GROUP BY Users.FirstName, Users.LastName		--Sedmi upit

SELECT Restaurants.Name, AVG(Ratings.Rating) AS AverageRating 
FROM Ratings
JOIN Restaurants ON Ratings.RestaurantId = Restaurants.RestaurantId
WHERE Restaurants.City = 'Rijeka'
GROUP BY Restaurants.Name		--Osmi upit 

SELECT Restaurants.Name 
FROM Restaurants
JOIN Orders ON Restaurants.RestaurantId = Orders.RestaurantId
WHERE Restaurants.Capacity > 30
GROUP BY Restaurants.Name		--Deveti upit


DELETE FROM Foods
WHERE FoodId NOT IN (
    SELECT DISTINCT oi.FoodId
    FROM OrderItems oi
    JOIN Orders o ON oi.OrderId = o.OrdersId						
    WHERE o.OrderDate >= NOW() - INTERVAL '2 years'		--Deseti upit 
)



UPDATE Users
SET LoyaltyCard = 'Ne'
WHERE UserId NOT IN (
    SELECT DISTINCT UserId 
    FROM Orders
    WHERE OrderDate >= NOW() - INTERVAL '1 year')			--Jedanesti upit
	





	














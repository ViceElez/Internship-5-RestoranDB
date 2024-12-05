CREATE TABLE Restaurants (
    RestaurantId SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    City VARCHAR(100) NOT NULL,
    Capacity INT,
    WorkingHours TIME
)

ALTER TABLE Restaurants
	DROP COLUMN WorkingHours
ALTER TABLE Restaurants
	ADD COLUMN OpeningHours TIME
ALTER TABLE Restaurants
	ADD COLUMN ClosingHours TIME


CREATE TABLE Foods (
    FoodId SERIAL PRIMARY KEY,
    RestaurantId INT REFERENCES Restaurants(RestaurantId),
    Name VARCHAR(100) NOT NULL,
    Category VARCHAR(20) CHECK(Category in ('Predjelo','Glavno jelo', 'Desert')),
    Price DECIMAL(10, 2),
    Calories FLOAT,
    Availability VARCHAR(20) CHECK(Availability in ('Dostupno','Ne dostupno'))
)

ALTER TABLE Foods
	ADD CONSTRAINT PriceIsPositive CHECK(Price>0)
ALTER TABLE Foods
	ADD CONSTRAINT Unique_FoodMenuId_Name UNIQUE (RestaurantId, Name)


CREATE TABLE Users (
    UserId SERIAL PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    LoyaltyCard VARCHAR(20) CHECK(LoyaltyCard in('Da','Ne'))
)

ALTER TABLE Users
	DROP COLUMN LoyaltyCard
ALTER TABLE Users
	ADD COLUMN OrdersMade INT 
ALTER TABLE Users
	ADD COLUMN MoneySpent FLOAT
ALTER TABLE Users
	ADD COLUMN LoyaltyCard VARCHAR(20) CHECK(LoyaltyCard in('Da','Ne'))
ALTER TABLE Users
	ADD CONSTRAINT IsEligableForLoyalty CHECK(
	(MoneySpent>=1000 AND OrdersMade>=15 AND LoyaltyCard='Da') OR (LoyaltyCard='Ne'))




CREATE TABLE Orders (
    OrdersId SERIAL PRIMARY KEY,
	UserId INT REFERENCES Users(UserId),
    RestaurantId INT REFERENCES Restaurants(RestaurantId),
    TotalAmount DECIMAL(10, 2),
    OrderDate DATE ,
    OrderType VARCHAR(50) CHECK(OrderType in ('Vanka','Restoran'))
)

ALTER TABLE Orders
	ADD COLUMN  DeliveryAddress VARCHAR(255) NOT NULL
ALTER TABLE Orders
	ADD COLUMN  UserReminder VARCHAR(255) NOT NULL
ALTER TABLE Orders
	DROP CONSTRAINT DeliveryAddress
ALTER TABLE Orders
	DROP COLUMN UserReminder
ALTER TABLE Orders
	ADD COLUMN  UserReminder VARCHAR(500) NOT NULL


CREATE TABLE OrderItems (
    OrderItemsId SERIAL PRIMARY KEY,
    OrderId INT REFERENCES Orders(OrdersId),
    FoodId INT REFERENCES Foods(FoodId),
    Quantity INT,
    Price DECIMAL(10, 2)
)


CREATE TABLE Staff (
    StaffId SERIAL PRIMARY KEY,
    RestaurantId INT REFERENCES Restaurants(RestaurantId),
    Name VARCHAR(100),
    Age INT,
    Roles VARCHAR(50)  CHECK(Roles IN ('Kuhar','Konobar','Dostavljac')), 
    DriversLicence VARCHAR(10) CHECK(DriversLicence in ('Da','Ne')) 
)

ALTER TABLE Staff
	ADD CONSTRAINT AgePositive CHECK(Age>0)

ALTER TABLE Staff
  DROP COLUMN Roles

ALTER TABLE Staff
  DROP COLUMN DriversLicence

ALTER TABLE Staff
  ADD COLUMN DriversLicence VARCHAR(10) CHECK(DriversLicence in ('Da','Ne'))

ALTER TABLE Staff
  ADD COLUMN Roles VARCHAR(50) CHECK(Roles IN ('Kuhar', 'Konobar', 'Dostavljac'))

ALTER TABLE Staff
	ADD CONSTRAINT checkAge CHECK( 
	(Roles = 'Kuhar' AND Age>=18) OR 
        (Roles != 'Kuhar'))
ALTER TABLE Staff
	ADD CONSTRAINT checkLicence CHECK (
        (Roles = 'Dostavljac' AND DriversLicence = 'Da') OR 
        (Roles != 'Dostavljac'))


CREATE TABLE Ratings (
    RatingsId SERIAL PRIMARY KEY,
    UserId INT REFERENCES Users(UserId),
    RestaurantId INT REFERENCES Restaurants(RestaurantId) ,
    FoodId INT REFERENCES Foods(FoodId),
    Rating INT,
    Comment VARCHAR(500),
    RatingDate DATE
)

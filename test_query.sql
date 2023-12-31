/*
Task 1
Print the names of all the people who are in the airline database
Fields in the resulting table:
name
*/

SELECT name
FROM Passenger;

/*
Task 2
Print the names of all airlines
Fields in the resulting table:
name
*/

SELECT name
FROM Company;

/*
Task 3
Print all trips made from Moscow
Fields in the resulting table:
*
*/

SELECT *
FROM Trip
WHERE town_from = 'Moscow';

/*
Task 4
Print the names of people that end in "man"
Fields in the resulting table:
name
*/

SELECT name
FROM Passenger
WHERE name LIKE '%man';

/*
Task 5
Print the number of trips completed on TU-134
Fields in the resulting table:
count
Use the "as count" construct for the aggregate function of counting the number of trips. This is necessary for validation.
*/

SELECT Count(*) AS count
FROM Trip
WHERE plane = 'TU-134';

/*
Task 6
Which companies have flown on Boeing
Fields in the resulting table:
name
*/

SELECT name
FROM Company

INNER JOIN Trip On Company.id = Trip.company
WHERE plane = 'Boeing'
Group BY name;


/*
Task 7
Display all the names of aircraft that you can fly to Moscow
Fields in the resulting table:
plane
*/

SELECT plane
FROM Trip
WHERE town_to = "Moscow"
GROUP BY plane;

/*
Task 8
What cities can I fly to from Paris and how long will it take?
Fields in the resulting table:
town_to
flight_time
Use the "as flight_time" construct to output the required time. This is necessary for correct verification.
The format for the output time: HH:MM:SS
*/

SELECT town_to, TIMEDIFF(time_in,time_out) AS flight_time 
FROM Trip
WHERE town_from ='Paris';

/*
Task 9
What companies organize flights from Vladivostok?
Fields in the resulting table:
name
*/

SELECT name FROM Company 
INNER JOIN Trip On Company.id = Trip.company
WHERE town_from = 'Vladivostok'
Group BY name;

/*
Task 10
Print trips made from 10 a.m. to 2 p.m. on January 1, 1900.
Fields in the resulting table:
*
*/

SELECT * FROM Trip
WHERE CAST(time_out AS DATE)="1900-01-01" 
AND CAST(time_out AS TIME)
BETWEEN '10:00:00' and '14:00:00';


/*
Task 11
Print the passengers with the longest full name. Spaces, hyphens, and dots are considered part of the name.
Fields in the resulting table:
name
*/

SELECT name FROM Passenger
WHERE LENGTH(name)= 
(SELECT max(LENGTH(name)) FROM Passenger) 
ORDER BY name;

/*
Task 12
Print the id and number of passengers for all past trips
Fields in the resulting table:
trip
count
Use the "as count" construction for the aggregate passenger count function. This is necessary for correct verification.
*/

SELECT trip, COUNT(passenger) As count
FROM Pass_in_trip
GROUP BY trip ;

/*
Task 13
Display the names of people who have a full namesake among passengers
Fields in the resulting table:
name
*/

SELECT name FROM Passenger 
GROUP BY name HAVING COUNT(*) > 1;

/*
Task 14
Which cities did Bruce Willis visit
Fields in the resulting table:
town_to
*/
SELECT town_to FROM Trip

JOIN Pass_in_trip
ON Trip.id = Pass_in_trip.trip

JOIN Passenger
ON Passenger.id = Pass_in_trip.passenger
AND Passenger.name = 'Bruce Willis'
ORDER BY town_to;

/*
Task 15
Print the date and time of arrival of the passenger Steve Martin to London (London)
Fields in the resulting table:
time_in
*/
SELECT time_in FROM Trip

JOIN Pass_in_trip
ON Trip.id = Pass_in_trip.trip
AND town_to = 'London'

JOIN Passenger
ON Passenger.id = Pass_in_trip.passenger
AND Passenger.name = 'Steve Martin'
ORDER BY time_in;

/*
Task 16
Display the list of passengers sorted by the number of flights (in descending order) and name (in ascending order) who have made at least 1 flight.
Fields in the resulting table:
name, count
 Use the "as count" construction for the aggregate function for counting the number of trips. This is necessary for correct verification.
*/

SELECT name, COUNT(*) as count
FROM Passenger 

JOIN Pass_in_trip
ON Pass_in_trip.passenger = Passenger.id 

JOIN Trip
ON Trip.id = Pass_in_trip.trip
GROUP BY name
ORDER BY count DESC, name ASC;

/*
Task 17
Determine how much each family member spent in 2005. 
In the resulting sample, do not output those family members who have not spent anything.
Fields in the resulting table:
member_name
status
costs
Use the "as costs" construct to display the amount spent by a family member. 
This is necessary for correct verification.
*/

SELECT fm.member_name, fm.status, sum(p.amount * p.unit_price) as costs
FROM FamilyMembers fm

JOIN Payments p
ON p.family_member = fm.member_id
AND YEAR(p.date)='2005'
GROUP BY fm.member_name, fm.status;

/*
Task 18
Find out who is the oldest in the family
Fields in the resulting table:
member_name
*/

/* Solution 1

SELECT member_name 
FROM  FamilyMembers
ORDER BY birthday
LIMIT 1;
*/

/* Solution 2*/

SELECT member_name 
FROM  FamilyMembers
WHERE birthday = (SELECT MIN(birthday) FROM FamilyMembers);

/*Task 19
Determine which family member bought potatoes (potato)
Fields in the resulting table:
status*/

/* Solution 1

SELECT fm.status 
FROM  FamilyMembers fm
JOIN Payments p 
ON p.family_member = fm.member_id
JOIN Goods g
ON g.good_id = p.good
AND g.good_name = 'potato' 
GROUP BY fm.status;*/

/* Solution 2*/

SELECT DISTINCT(fm.status) 
FROM  FamilyMembers fm

JOIN Payments p 
ON p.family_member = fm.member_id

JOIN Goods g
ON g.good_id = p.good
AND g.good_name = 'potato'; 

/*Task 20
How much and who from the family spent on entertainment. Print family status, name, amount
Fields in the resulting table:
status
member_name
costs
Use the "as costs" construct to display the amount spent by a family member. 
This is necessary for correct verification.*/

SELECT fm.status, fm.member_name, (p.amount * p.unit_price) as costs
FROM Payments p

JOIN FamilyMembers fm
ON fm.member_id = p.family_member

JOIN Goods g 
ON g.good_id = p.good

JOIN GoodTypes gt 
ON gt.good_type_id = g.type
AND gt.good_type_name = 'entertainment';

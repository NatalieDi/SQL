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
FROM Company

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
Group BY trip ;

/*
Task 13
Display the names of people who have a full namesake among passengers
Fields in the resulting table:
name
*/

SELECT name FROM Passenger 
GROUP BY name HAVING COUNT(*) > 1;


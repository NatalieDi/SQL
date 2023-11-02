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

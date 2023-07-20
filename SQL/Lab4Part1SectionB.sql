
-- Question B:
-- For each classification task, compute the total number of instances in the data set, 
-- as well as the number of instances in each class and the corresponding proportion. 
-- Present the SQL queries used to compute these numbers.
use baseballdb;

-- get number of people in the data set.
SET @numberOfPeople = (SELECT COUNT(*) FROM people);

-- get the number of people in the halloffame data set (therefore =they are in the Nominated class).
SET @numberNominated = (select COUNT(DISTINCT(playerID)) from halloffame);

-- get the number of people in the NOT Nominated class.
SET @numberNotNominated = (@numberOfPeople - @numberNominated);

-- calculate the percentage of people that were nominated.
SET @percentNominated = ((@numberNominated/@numberOfPeople)*100);

-- calculate the percentage of people that were NOT nominated.
SET @percentNotNominated = ((@numberNotNominated/@numberOfPeople)*100); 

-- Select all the data points
SELECT @numberOfPeople as "Number of People", @numberNominated as "Number Nominated",
@numberNotNominated as "Number NOT Nominated", @percentNominated as "Percent Nominated",
@percentNotNominated as "Percent NOT Nominated";
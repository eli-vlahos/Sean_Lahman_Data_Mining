use baseballdb;

-- Step 1: Get number of people in the data set.
SET @numberOfPeople = (SELECT COUNT(*) FROM people);

-- Step 2: Get the number of people in the halloffame data set (therefore =they are in the Nominated class).
SET @numberNominated = (select COUNT(DISTINCT(playerID)) from halloffame);

-- Step 3: Get the number of people in the NOT Nominated class.
SET @numberNotNominated = (@numberOfPeople - @numberNominated);

-- Step 4: Calculate the percentage of people that were nominated.
SET @percentNominated = ((@numberNominated/@numberOfPeople)*100);

-- Step 5: Calculate the percentage of people that were NOT nominated.
SET @percentNotNominated = ((@numberNotNominated/@numberOfPeople)*100);

-- Step 6: Select all the data points.
SELECT @numberOfPeople as "Number of People", @numberNominated as "Number Nominated",
@numberNotNominated as "Number NOT Nominated", @percentNominated as "Percent Nominated",
@percentNotNominated as "Percent NOT Nominated";


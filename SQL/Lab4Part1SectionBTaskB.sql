use baseballdb;

-- Step 1: Get number of people in the data set (i.e number of people nominated for halloffame).
SET @numberNominated = (select COUNT(DISTINCT(playerID)) from halloffame);

-- Step 2: Get the number of people who were eventually inducted.
SET @numberInducted = (select count(*) from
						(select playerID, max(inducted) as inducted
							from HallOfFame
							group by playerID) as temp
						where inducted = 'Y');

-- Step 3: Get the number of people in the NOT inducted class.
SET @numberNotInducted = (@numberNominated - @numberInducted);

-- Step 4: Calculate the percentage of people that were inducted.
SET @percentInducted = ((@numberInducted/@numberNominated)*100);

-- Step 5: Calculate the percentage of people that were NOT inducted.
SET @percentNotInducted = ((@numberNotInducted/@numberNominated)*100); 

-- Step 6: Select all the data points.
SELECT @numberNominated as "Number Nominated", @numberInducted as "Number Inducted",
@numberNotInducted as "Number NOT Inducted", @percentInducted as "Percent Inducted",
@percentNotInducted as "Percent NOT Inducted";


›
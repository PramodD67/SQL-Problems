-- Table: Stadium

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | visit_date    | date    |
-- | people        | int     |
-- +---------------+---------+
-- visit_date is the column with unique values for this table.
-- Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
-- As the id increases, the date increases as well.
 

-- Write a solution to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.

-- Return the result table ordered by visit_date in ascending order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Stadium table:
-- +------+------------+-----------+
-- | id   | visit_date | people    |
-- +------+------------+-----------+
-- | 1    | 2017-01-01 | 10        |
-- | 2    | 2017-01-02 | 109       |
-- | 3    | 2017-01-03 | 150       |
-- | 4    | 2017-01-04 | 99        |
-- | 5    | 2017-01-05 | 145       |
-- | 6    | 2017-01-06 | 1455      |
-- | 7    | 2017-01-07 | 199       |
-- | 8    | 2017-01-09 | 188       |
-- +------+------------+-----------+
-- Output: 
-- +------+------------+-----------+
-- | id   | visit_date | people    |
-- +------+------------+-----------+
-- | 5    | 2017-01-05 | 145       |
-- | 6    | 2017-01-06 | 1455      |
-- | 7    | 2017-01-07 | 199       |
-- | 8    | 2017-01-09 | 188       |
-- +------+------------+-----------+
-- Explanation: 
-- The four rows with ids 5, 6, 7, and 8 have consecutive ids and each of them has >= 100 people attended. Note that row 8 was included even though the visit_date was not the next day after row 7.
-- The rows with ids 2 and 3 are not included because we need at least three consecutive ids.
------------------------------------------------------

--QUERY:

WITH CTE0 AS (
    SELECT * FROM 
    STADIUM 
    WHERE PEOPLE>=100
)

, CTE1 AS (
SELECT *, (ID-RN) AS CONS FROM (
SELECT *, ROW_NUMBER() OVER (ORDER BY id) AS RN FROM CTE0 ) T
)
, 
CTE2 AS (
    SELECT CONS
    FROM CTE1
    GROUP BY CONS
    HAVING COUNT(*)>=3
)

SELECT id,visit_date, people FROM CTE1 WHERE CONS IN ( SELECT CONS FROM CTE2);

------------------------------------------------

-- 🔍 Explanation:
-- filtered: Filters rows where people >= 100.
-- grouped: Uses ROW_NUMBER() to detect consecutive ids by computing id - row_number. This value (grp) is constant for consecutive sequences.
-- valid_groups: Selects only those groups that have 3 or more rows.
-- Final SELECT: Returns all rows from those valid groups, ordered by visit_date.
-- ✅ Output for Your Example:
-- Given this input:

-- | id | visit_date | people |
-- |----|------------|--------|
-- | 1  | 2017-01-01 | 10     |
-- | 2  | 2017-01-02 | 109    |
-- | 3  | 2017-01-03 | 150    |
-- | 4  | 2017-01-04 | 99     |
-- | 5  | 2017-01-05 | 145    |
-- | 6  | 2017-01-06 | 1455   |
-- | 7  | 2017-01-07 | 199    |
-- | 8  | 2017-01-09 | 188    |
-- The output will be:

-- | id | visit_date |------------|--------|
-- | 5  | 2017-01-05 | 145    |
-- | 6  | 2017-01-06 | 1455   |
-- | 7  | 2017-01-07 | 199    |
-- | 8  | 2017-01-09 | 188    |
-- Let me know if you'd like to adapt this for a specific SQL dialect or test it with your own data!
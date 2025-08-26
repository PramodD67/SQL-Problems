create table numb_tbl(id number) ;

insert into numb_tbl(id) values(12);

table numb_tbl;

--NOT WORKING
select id  from (select id,
row_number() over (order by id) as rn,
lag(id,1,0) over(order by id asc) as lg1,
lag(id,2,0) over(order by id asc) as lg2
from numb_tbl  ) v
where v.id=v.lg1+1 and v.lg1=v.lg2+1;


--NOT WORKING
SELECT id
FROM (
    SELECT id,
           LAG(id, 1) OVER (ORDER BY id) AS prev1,
           LAG(id, 2) OVER (ORDER BY id) AS prev2
    FROM numb_tbl
) t
WHERE id = prev1 + 1 AND prev1 = prev2 + 1;

------------------------------------

--Working:
SELECT a.ID, b.ID, c.ID
FROM numb_tbl a
JOIN numb_tbl b ON b.ID = a.ID + 1
JOIN numb_tbl c ON c.ID = b.ID + 1;
---------------------------------------

--METHOD 2: SUBTRACT ID FROM ROW NUMBER THEN USE GROUP BY TO FIND MORE THAN 3 CONSECUTIVE NUMBERS.

WITH CTE AS (
SELECT * FROM (
    SELECT *, 
           ROW_NUMBER() OVER (ORDER BY id) AS RN,
           (ID-RN) AS CONS
    FROM numb_tbl
) )
, CTE2 AS (
SELECT CONS FROM CTE
GROUP BY CONS
HAVING COUNT(*)>=3)

SELECT * FROM CTE WHERE CONS IN (SELECT CONS FROM CTE2);

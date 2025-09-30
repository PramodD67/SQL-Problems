# SQL-Problems

Rules:

1. In grouped queries, any column used in ORDER BY must be:
  - In the SELECT list, and
  - Either part of GROUP BY or an aggregate function.

2.  When using GROUP BY, every column in your SELECT list must either:
   • Be in the GROUP BY clause,
       OR
   • Be inside an aggregate function (like COUNT(), MAX(), etc.

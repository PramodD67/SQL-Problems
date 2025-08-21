create table person(id number, email varchar);

insert into  person(id, email) values(1,'bob@example.com');
insert into  person(id, email) values(2,'john@example.com');
insert into  person(id, email) values(3,'john@example.com');

select * from person;

delete from person where id in (
select id from (
with cte as (
select id,row_number() over ( partition by email order by email) as rn
from person
)
 select * from cte where rn>1));

 select * from person;


---Method 2:
delete from person where id in (
select id from (
      select id,row_number() over ( partition by email order by email) as rn
       from person 
) R
where R.rn>1


 

--Method 3: But won't works in most of DB's
 with cte as (
    select *, 
    row_number() over (partition by email order by email ) as rn
    from Person 
)
delete from cte where rn>1;
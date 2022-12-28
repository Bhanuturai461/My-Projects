use employee;
select * from emp_record_table;
select emp_id,first_name,last_name,gender,dept from emp_record_table;

select emp_id,first_name,last_name,gender,dept,emp_rating from emp_record_table
where emp_rating<2; 

select emp_id,first_name,last_name,gender,dept,emp_rating from emp_record_table
where emp_rating>4; 

select emp_id,first_name,last_name,gender,dept,emp_rating from emp_record_table
where emp_rating between 2 and 4;

select first_name,last_name,concat(first_name,last_name) as name,dept from emp_record_table
where dept='finance';                                                                             ---- 5---

select manager_id,count(emp_id) from emp_record_table
group by manager_id;                                                               ---- 6 ----

select emp_id, dept from emp_record_table where dept='healthcare' 
union
select emp_id,dept from emp_record_table where dept='finance';                     ---- 7 ----
                                                                
 select emp_id,first_name,last_name,gender,dept,emp_rating,max(emp_rating) over (partition by dept)
 as maxemp_rating from emp_record_table;                                                                ---- 8 ----
 
 select role,salary from emp_record_table;
 
select role,salary from emp_record_table
where salary in (select max(salary) from emp_record_table group by role
union select min(salary) from  emp_record_table group by role);                   ---- 9 ----
                 
select role,salary from emp_record_table
where salary = (select max(salary) from emp_record_table) or
      salary = (select min(salary) from emp_record_table)
      order by role desc;                                                                  ---- 9 ----

select emp_id,exp, 
rank() over(order by exp) as ranks from emp_record_table; 

select emp_id,exp, 
dense_rank() over(order by exp) as ranks from emp_record_table;                          ---- 10 ----

create view employee_details as select emp_id,country,salary from emp_record_table
where salary>6000 
order by salary desc;  
select * from employee_details;                                           ---- 11 ----    


select emp_id,first_name,last_name,role,dept,country,salary,exp from emp_record_table where exp in (select exp from emp_record_table where exp>10);     ---- 12 ----
select emp_id,first_name,last_name,role,dept,country,salary,exp from emp_record_table where exp > 10;
delimiter //
create procedure emp_info(in var int)
begin 
select emp_id,exp from emp_record_table ;
end // 
delimiter ;
call emp_info(3);                                                                  ---- 13 ----

select emp_id,country,exp,
case
when exp <=2 then 'junior data scientist'
when exp between 2 and 5 then 'associate data scientist'
when exp between 5 and 10 then 'senior data scientist'
when exp between 10 and 12 then 'lead data scientist'
when exp between 12 and 16 then 'manager'       
end as employee_level
from data_science_team;                                          ---- 14-----

create index employee_index on emp_record_table (first_name);
select emp_id,first_name,last_name,role,dept,country,salary,exp from emp_record_table where first_name like 'eric%';      ---- 15 ----

select emp_id, round((5/100 * salary * emp_rating),2) as bonus from emp_record_table;              ---- 16 ----

select continent,country,round(avg(salary),2) as avg_salary from emp_record_table
group by country;                                                                                  ---- 17 ----
drop  index first_name on emp_record_table;


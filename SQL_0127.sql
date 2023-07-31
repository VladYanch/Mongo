use hr;
select * from employees;

select max(salary)
from hr.employees;

select
	* 
    from employees
    where salary = (
		select
			max(salary)
		from hr.employees
        );
        
select
	* 
    from employees
    where employee_id in (
		select
			employee_id
		from hr.employees
        where department_id = 90
        );

-- найти департаменты где нет ни одного сотрудника

select department_name
from hr.departments    
where department_id not in (
	select
	department_id
    from hr.employees
    where department_id is not null);

-- вывести имя и фамилию сотрудника у кого зп выше средней
select 
	first_name,
	last_name,
	salary
from hr.employees
where salary > (
select avg(salary)
from hr.employees);

-- вывести имя и фамилию сотрудника у кого зп выше средней в своем департаменте
select
	t1.first_name,
    t1.last_name,
    t1.salary
from hr.employees t1
inner join (
select
	avg(salary) as max_salary
    from hr.employees
    group by department_id
) t2;


-- визуальная проверка выполнения запроса
select
 t1.first_name,
    t1.last_name,
    t1.salary,
    case 
  when t1.first_name = t2.first_name and t1.last_name = t2.last_name
   then 1
  else 0
 end as test
from hr.employees t1
left join (
 select
  employee_id,
  first_name,
  last_name
 from hr.employees
 where salary > (
  select avg(salary) from hr.employees
 )
) t2 
on t1.employee_id = t2.employee_id;

select
	first_name,
    last_name,
    salary,
    case 
		when salary < 5000 then 1
		when salary < 10000 then 2
		else 3
	end as salary_group
from hr.employees;
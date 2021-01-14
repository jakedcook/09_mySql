create table salaries ( 
	emp_no int not null,
	salary int not null,
	primary key(emp_no)
);

create table titles (
	title_id varchar(5) not null,
	title varchar(250) not null,
	primary key (title_id)
);

create table employees (
	emp_no int not null, 
	emp_title_id varchar(5) not null,
	birth_date date not null, 
	first_name varchar(250) not null,
	last_name varchar(250) not null,
	sex char(1) not null,
	hire_date date not null, 
	primary key (emp_no),
		foreign key (emp_no) references salaries(emp_no),
		foreign key (emp_title_id) references titles(title_id)
);

create table departments (
	dept_no varchar(5) not null, 
	dept_name varchar(150),
	primary key (dept_no)
);

create table dept_manager (
	dept_no varchar(5) not null, 
	emp_no int not null, 
	primary key (dept_no, emp_no),
		foreign key (dept_no) references departments(dept_no),
		foreign key (emp_no) references employees(emp_no)
);

create table dept_emp (
	emp_no int not null,
	dept_no varchar(5) not null,
	primary key (emp_no, dept_no),
		foreign key (emp_no) references employees(emp_no),
		foreign key (dept_no) references departments(dept_no)
);

--1. list the following deatils of each employee: employee number, last name, first name, sex and salary
create view emp_details as
select
	e.emp_no, 
	e.last_name,
	e.first_name, 
	e.sex,
	s.salary
from employees as e
join salaries as s
on e.emp_no=s.emp_no;

select * from emp_details;

--2. list first name, last name, and dire date for employees who were hired in 1986
create view hire_1986 as 
select
	e.first_name,
	e.last_name,
	e.hire_date
from employees as e where hire_date between '1986-01-01' and '1987-01-01';

select * from hire_1986;

--3. list the manager of each department with the following information: department number, department name,
-- manager's employee number, last namen first name 
create view manager as
select 
	d.dept_no,
	d.dept_name,
	dm.emp_no,
	e.last_name,
	e.first_name
from dept_manager as dm
join departments as d on d.dept_no = dm.dept_no
join employees as e on dm.emp_no = e.emp_no;

select * from manager;

--4. list the department of each employee with the following information: employee number, last name, 
--first name, and department name
create view emp_department as 
select 
	e.emp_no,
	e.first_name, 
	e.last_name, 
	d.dept_name
from employees as e
join dept_emp as de on e.emp_no = de.emp_no
join departments as d on de.dept_no = d.dept_no;

select * from emp_department;

--5. list first name, last name, and sex for employees whose first name is "hercules" and last names begin with "B"
create view hercules as 
select 
	first_name, 
	last_name, 
	sex
from employees where first_name = 'Hercules' and last_name like '%B';

select * from hercules;
--6. list all employees in the sales department, including their employee number, last name, first name,
-- and department name 
create view sales as 
select
	d.dept_name, 
	e.emp_no, 
	e.last_name,
	e.first_name
from employees as e 
join dept_emp as de
on e.emp_no = de.emp_no
join departments as d
on de.dept_no = d.dept_no where d.dept_name = 'Sales';

select * from sales;
	
--7. list all employees in the sales and development departments, including their employee number,
--last name, first name, and department name
create view sd_department as 
select 
	e.emp_no,
	e.last_name, 
	e.first_name, 
	d.dept_name
from employees as e 
join dept_emp as de
on e.emp_no = de.emp_no
join departments as d on de.dept_no = d.dept_no
where d.dept_name = 'Sales' or d.dept_name = 'Development';

select * from sd_department;
--8. In descending order, list the frequency count of employee last names, i.e., how many employees 
--share each last name 
create view name_count as 
select 
	e.last_name, count(e.last_name)
from employees as e
group by e.last_name
order by count(e.last_name) desc;

select * from name_count;
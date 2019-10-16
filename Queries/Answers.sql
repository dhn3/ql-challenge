-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no AS "Employee Number",
		employees.last_name AS "Last Name",
		employees.first_name AS "First Name",
		employees.gender AS "Gender",
		salaries.salary AS "Salary"
FROM employees 
JOIN salaries
ON employees.emp_no = salaries.emp_no;

-- 2. List employees who were hired in 1986.
SELECT first_name || ' ' || last_name as "Employee Name", hire_date
FROM employees
where EXTRACT(YEAR FROM hire_date) = 1986;

-- 3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name, 
-- and start and end employment dates.

select d.dept_no as "Department Number", 
		d.dept_name as "Department Name", 
		dme.emp_no as "Employee Number", 
		dme.first_name as "First Name", 
		dme.last_name as "Last Name"
from departments d
inner join (select dm.dept_no, dm.emp_no, e.first_name, e.last_name
	 from dept_manager dm
	 inner join employees e
	 on dm.emp_no=e.emp_no) dme
on d.dept_no=dme.dept_no;

-- 4. List the department of each employee with the following information: employee number, 
--last name, first name, and department name.

select e.emp_no as "Employee Number", 
		e.last_name as "Last Name", 
		e.first_name as "First Name", 
		ded.dept_name as "Department Name"
from employees e
join (select d.dept_name, de.emp_no 
	  	from departments d
	 	join dept_emp de
	 	on d.dept_no=de.dept_no) ded
on e.emp_no=ded.emp_no;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
select first_name as "First Name", 
		last_name as "Last Name"
from employees
where first_name='Hercules' and last_name like 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
select e.emp_no as "Employee Number", 
		e.last_name as "Last Name", 
		e.first_name as "First Name", 
		ded.dept_name as "Department Name"
from employees e
join (select d.dept_name, de.emp_no 
	  	from departments d
	 	join dept_emp de
	 	on d.dept_no=de.dept_no) ded
on e.emp_no=ded.emp_no
where ded.dept_name='Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select e.emp_no as "Employee Number", 
		e.last_name as "Last Name", 
		e.first_name as "First Name", 
		ded.dept_name as "Department Name"
from employees e
join (select d.dept_name, de.emp_no 
	  	from departments d
	 	join dept_emp de
	 	on d.dept_no=de.dept_no) ded
on e.emp_no=ded.emp_no
where ded.dept_name='Sales' or ded.dept_name='Development';


-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name as "Last Name", count(last_name) as "Count"
from employees
group by last_name
order by count(last_name) desc;
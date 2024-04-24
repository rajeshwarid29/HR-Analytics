USE hr_data;
show tables;
select * from employee_survey_data;
select * from manager_survey_data;
select * from general_data;

#1) Retrieve the total number of employees in the datset
select count(*) as employee_count
from employee_survey_data;

#2) List all unique job roles in the dataset
select distinct jobrole
from general_data;

#3) Find the average age of employees.
select avg (age) as avg_age
from general_data;

#4) Retrieve the names and ages of employees who have worked at the company for more than 5 years.
select emp_name, age
from general_data
where yearsatcompany > 5;

#5) Get a count of employees grouped by their department.
select department, count(employeeid) as emp_count from general_data
group by department;

#6) List employees who have 'High' Job Satisfaction.
select g.emp_name, e.jobsatisfaction
from general_data g
join employee_survey_data e on e.employeeid = g.employeeid
where e.jobsatisfaction = 3;

 #7) Find the highest Monthly Income in the dataset.
select monthlyincome as highest_monthly_income
from general_data 
order by monthlyincome desc 
limit 1;

#8) List employees who have 'Travel_Rarely' as their BusinessTravel type.
select emp_name, businesstravel 
from general_data
where businesstravel = 'travel_rarely';

#9) Retrieve the distinct MaritalStatus categories in the dataset
select distinct maritalstatus from general_data;

#10) Get a list of employees with more than 2 years of work experience but less than 4 years in their current role.
SELECT emp_name, totalworkingyears
FROM general_data
WHERE totalworkingyears > 2 AND totalworkingyears < 4;

#11) List employees who have changed their job roles within the company (JobLevel and JobRole differ from their previous job).
    SELECT emp_name, previous_jobrole, previous_joblevel, new_jobrole, new_joblevel
FROM (
    SELECT 
        emp_name, 
        jobrole AS new_jobrole, 
        joblevel AS new_joblevel, 
        LAG(jobrole) OVER(PARTITION BY emp_name ORDER BY yearsatcompany) AS previous_jobrole,
        LAG(joblevel) OVER(PARTITION BY emp_name ORDER BY yearsatcompany) AS previous_joblevel
    FROM general_data
) AS job_changes
WHERE previous_jobrole IS NOT NULL AND (previous_jobrole != new_jobrole OR previous_joblevel != new_joblevel);

#12)  Find the average distance from home for employees in each department.
select department, avg (distancefromhome) as avg_distance_for_emp
from general_data
group by department;

#13) Retrieve the top 5 employees with the highest MonthlyIncome
select emp_name, monthlyincome
from general_data
order by monthlyincome desc
limit 5;

#14) Calculate the percentage of employees who have had a promotion in the last year
Select (COUNT(CASE WHEN YearsSinceLastPromotion = 1 then 1 end) * 100.0 / COUNT(*)) as percentage_promoted_last_year
from general_data;

#15) List the employees with the highest and lowest EnvironmentSatisfaction.
select g.emp_name, max(e.environmentsatisfaction) as highest_environment_satisfaction, 
min(e.environmentsatisfaction) as lowest_environment_satisfaction
from general_data g
join employee_survey_data e on e.employeeid = g.employeeid
group by emp_name;

#16) Find the employees who have the same JobRole and MaritalStatus.
select * from general_data;
select g.emp_name, g.jobrole, g.maritalstatus
from general_data g
inner join general_data h
on g.jobrole = h.jobrole and g.maritalstatus = h.maritalstatus and g.employeeid <> h.employeeid;

#17) List the employees with the highest TotalWorkingYears who also have a PerformanceRating of 4
select G.Emp_Name, M.PerformanceRating, G.TotalWorkingYears
from general_data G
join manager_survey_data M
on G.EmployeeID = M.EmployeeID
where PerformanceRating = 4
order by TotalWorkingYears desc;

#18) Calculate the average Age and JobSatisfaction for each BusinessTravel type.
select g.businesstravel,
avg(g.age) as avg_age,
avg(e.jobsatisfaction) as avg_jobsatisfaction
from general_data g
join employee_survey_data e 
on g.employeeid = e.employeeid
group by businesstravel;

#19) Retrieve the most common EducationField among employees.
select * from general_data;
select educationfield, count(*) as top_field
from general_data
group by educationfield
order by top_field desc
limit 1;

#20) List the employees who have worked for the company the longest but haven't had a promotion.
select * from general_data;
select emp_name, yearsatcompany, yearssincelastpromotion
from general_data
where yearssincelastpromotion = 0
order by yearsatcompany desc;

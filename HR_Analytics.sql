create database HR_analytics;
use HR_analytics;
desc hrdata;
create table hrdata
(
	emp_no int PRIMARY KEY,
	gender varchar(50) NOT NULL,
	marital_status varchar(50),
	age_band varchar(50),
	age int,
	department varchar(50),
	education varchar(50),
	education_field varchar(50),
	job_role varchar(50),
	business_travel varchar(50),
	employee_count int,
	attrition varchar(50),
	attrition_label varchar(50),
	job_satisfaction int,
	active_employee int
);
select * from hrdata;

-- KPI's
-- 1) Employee Count
select sum(employee_count) Employee_Count from hrdata;

-- 2) Attrition Count
select count(attrition) Attrition_Count from hrdata where attrition = 'Yes';

-- 3) Attrition Rate
select concat(round(((select count(attrition) Attrition_Count from hrdata where attrition = 'Yes')/
sum(employee_count))*100,2),'%') Attrition_Rate from hrdata;

-- 4) Active Employee 
select sum(employee_count) - (select count(attrition) from hrdata where attrition = 'Yes') Active_Employee 
from hrdata;

-- 5) Average Age
select round(avg(age),0) Average_Age from hrdata;

-- Visuals
-- 1) Attrition by gender
select gender, count(attrition) Attrition_Count from hrdata where attrition = 'Yes'
group by gender 
order by count(attrition) desc;

-- 2) Department wise Attrition
select department, count(attrition) Attrition_Count, 
concat(round((count(attrition)/(select count(attrition)
from hrdata where attrition = 'Yes'))*100,2),'%') Attrition_Count_percent
from hrdata where attrition = 'Yes'
group by department
order by count(attrition) desc;

-- 3) No. of Employees by age group
select age, sum(employee_count) employee_count from hrdata
group by age
order by age;
/* select age_band, count(employee_count) from hrdata
group by age_band
order by age_band; */

-- 4) Education field wise Attrition
select education_field, count(attrition) Attrition_Count
from hrdata where attrition = 'Yes'
group by education_field
order by Attrition_Count desc;

-- 5) Attrition Rate by gender for different age group
select age_band, gender, count(attrition) Attrition_Count,
concat(round((count(attrition)/(select count(attrition)
from hrdata where attrition = 'Yes'))*100,2),'%') Attrition_Count_percent
from hrdata where attrition = 'Yes'
group by age_band, gender
order by age_band, gender;

-- 6) Job Satisfaction Rating
select job_role, 
sum(case when job_satisfaction = 1 then employee_count end) as one,
sum(case when job_satisfaction = 2 then employee_count end) as two,
sum(case when job_satisfaction = 3 then employee_count end) as three,
sum(case when job_satisfaction = 4 then employee_count end) as four
from hrdata
group by job_role
order by job_role;


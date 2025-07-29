create database HR;

use HR;
select * from `hr`;
Alter table hr_2 rename column `ï»¿Employee ID`to `Employee ID`;

--- 1. Average Attrition rate for all Departments 


select Department, Round((sum(if(Attrition="Yes",1,0))/count(*))*100,2) as Avg_Attrition
from hr_1 group by 1 order by 2 desc;


---- 2. Average Hourly rate of male Research scientist

select Gender, jobRole, Round(avg(HourlyRate),2) as Avg_Hourly_Rate 
from hr_1 where Gender="male" and jobRole="Research Scientist";

-- 3. Attrition rate vs monthly income stats

select floor(monthlyincome/10000)*10000 as income_bin ,
Round((sum(if(Attrition="Yes",1,0))/count(*))*100,2) as Attrition_Rate
from  hr_1
inner join hr_2
on hr_1.EmployeeNumber = hr_2.`Employee ID`
group by 1 order by 1;


-- 4. Average working years for each Department

select hr_1.Department ,Round(avg(hr_2.YearsAtCompany),2) as Avg_working_year 
from  hr_1
inner join hr_2
on hr_1.EmployeeNumber = hr_2.`Employee ID`
group by 1;

--- 5.Job Role vs work life Balance

select JobRole,
 case
    when worklifebalance=4 then 'excellent'
    when worklifebalance=3 then 'good'
    when worklifebalance=2 then 'average'
    when worklifebalance=1 then 'poor'
    else 'null'
 end as worklife_balance, count(*) as Work_Life_Balance_count
 from hr_1
 inner join hr_2
 on hr_1.EmployeeNumber = hr_2.`Employee ID`
 group by 1,2 order by 1,3;


--- 6.Attrition rate vs Year since last promotion rate

select distinct YearsSinceLastPromotion, Round((sum(if(Attrition="Yes",1,0))/count(*))*100,2) as Attrition_Rate 
 from hr_1
 join hr_2 
 on hr_1.EmployeeNumber= hr_2.`Employee ID`
 group by 1 order by 1;




	
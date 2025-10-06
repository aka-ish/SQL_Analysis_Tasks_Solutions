SELECT * FROM sql_tasks.insurance_data;
use sql_tasks;
# Practise for DML Session 

-- 1. Show records of 'male' patient from 'southwest' region.
select * from insurance_data where gender ='male' and region='southwest';

-- Show all records having bmi in range 30 to 45 both inclusive.
select * from insurance_data where bmi between 30 and 45;

-- Show minimum and maximum bloodpressure of diabetic patient who smokes. Make column names as MinBP and MaxBP respectively.
select *, max(bloodpressure) as 'MaxBP',min(bloodpressure) as 'MinBP' 
from insurance_data 
where diabetic = 'Yes' and smoker = 'Yes';

-- Find no of unique patients who are not from southwest region.
select distinct(PatientID) from insurance_data where region <> 'southwest' ;
-- Total claim amount from male smoker.
select round(sum(claim),2) from insurance_data where gender = 'Male' and smoker = 'Yes';
-- select gender, round(sum(claim),2) from insurance_data where smoker = 'Yes'
-- group by gender;
-- Select all records of south region.
select * from insurance_data where region Like '%south%';

-- No of patient having normal blood pressure. Normal range[90-120].
select count(PatientID) from insurance_data where bloodpressure > 90 and bloodpressure < 120;

-- No of pateint below 17 years of age having normal blood pressure as per below formula -> BP normal range = (80+(age in years × 2)) to (100 + (age in years × 2))
select * from insurance_data where age<17 AND bloodpressure between (80 + (age*2)) and (100 + (age*2));

-- Note: Formula taken just for practice, don't take in real sense.

-- What is the average claim amount for non-smoking female patients who are diabetic?
select avg(claim) from insurance_data where gender = 'Female' and smoker = 'No' and diabetic = 'Yes';
-- Write a SQL query to update the claim amount for the patient with PatientID = 1234 to 5000.
UPDATE insurance_data 
set claim = 5000 
where PatientID = '1234';
select claim from insurance_data where PatientID = '1234';
-- Write a SQL query to delete all records for patients who are smokers and have no children.
select * from insurance_data where smoker = 'Yes' and children = 0;
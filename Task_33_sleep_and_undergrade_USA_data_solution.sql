SELECT count(*) FROM sql_tasks.sleep_data;
use sql_tasks;
select * from sleep_data;
-- Problem 1:Find out the average sleep duration of top 15 male candidates who's sleep duration are equal to 7.5 or greater than 7.5.
select Gender , avg(Sleep_duration) from sleep_data where Sleep_duration>= 7.5 and Gender = 'Male'
group by Gender 
order by Gender desc LIMIT 15;

-- Problem 2: Show avg deep sleep time for both gender. Round result at 2 decimal places.
-- Note: sleep time and deep sleep percentage will give you, deep sleep time.
select Gender, round(AVG(Sleep_duration*(`Deep sleep percentage`/100)),2) as 'avg_deep_sleep' 
from sleep_data  
group by Gender;
-- Problem 3:Find out the lowest 10th to 30th light sleep percentage records where deep sleep percentage values
 -- are between 25 to 45. Display age, light sleep percentage and deep sleep percentage columns only.
 select Age, `Light sleep percentage`, `Deep sleep percentage` from sleep_data 
 where `Deep sleep percentage` between 25 and 45
 order by `Light sleep percentage` asc limit 10,30;
 
-- Problem 4: Group by on exercise frequency and smoking status and show average deep sleep time, 
-- average light sleep time and avg rem sleep time.
-- Note the differences in deep sleep time for smoking and non smoking status
select `Exercise frequency`, `Smoking status`,
avg(Sleep_duration*(`Deep sleep percentage`/100)),
avg(Sleep_duration*(`REM sleep percentage`/100)),
avg(Sleep_duration*(`Light sleep percentage`/100))
from sleep_data 
group by `Exercise frequency`,`Smoking status`;

-- Problem 5: Group By on Awekning and show AVG Caffeine consumption, AVG Deep sleep time and AVG Alcohol consumption only for 
-- people who do exercise atleast 3 days a week. Show result in descending order awekenings
select Awakenings, avg(`Caffeine consumption`),avg(`Alcohol consumption`), avg(Sleep_duration*(`Deep sleep percentage`/100)) as 'avg_deep_sleep_time'
from sleep_data where `Exercise frequency`>=3
group by Awakenings
order by Awakenings desc;

# This set of problem use Power Generation Dataset
#Problem 6:Display those power stations which have average 'Monitored Cap.(MW)' (display the values) between 1000 and 2000 
-- and the number of occurance of the power stations (also display these values) are greater than 200. 
-- Also sort the result in ascending order.
show tables;
SELECT `Power Station`, avg(`Monitored Cap.(MW)`) as 'avg_capacity', count(*) as 'Occurance' 
FROM sql_tasks.power
group by `Power Station`
having (avg_capacity between 1000 and 2000) and Occurance>200
order by Avg_Capacity DESC;

-- Problem 7:Display top 10 lowest "value" State names of which the Year either belong to 2013 or 2017 or 2021 and 
-- type is 'Public In-State'. Also the number of occurance should be between 6 to 10. Display the average value 
-- upto 2 decimal places, state names and the occurance of the states.
select * from sql_tasks.undergrad;
select State, 
ROUND(AVG(Value),2) as 'Avg_Value',
count(*) as 'frequency' from sql_tasks.undergrad 
where Year in (2013,2017,2021) and Type = 'Public In-State'
group by State
having frequency between 6 and 10
order by Avg_Value asc limit 10;
select distinct(Year) from sql_tasks.undergrad;

-- Problem -8: Best state in terms of low education cost (Tution Fees) in 'Public' type university.
select State, AVG(Value) from sql_tasks.undergrad where Type Like '%Public%' and Expense LIKE '%Tuition%'
group by State
order by AVG(Value) asc limit 1;

-- Problem 9: 2nd Costliest state for Private education in year 2021. Consider, Tution and Room fee both.
select State,avg(Value) from sql_tasks.undergrad where Year = 2021 and Type Like '%Private%'
group by State;
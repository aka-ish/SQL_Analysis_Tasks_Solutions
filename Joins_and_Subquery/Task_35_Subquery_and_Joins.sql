use sql_tasks;
show databases;
use olympics;
-- Column description:
-- ID -> ID of every records to our dataset. It has integer datatype.
-- Name -> Name of the athletes.
-- Sex -> Gender of the athletes.
-- Height -> Height of the athletes
-- Weight -> Weight of the athletes
-- NOC -> In which country, the athletes belong to. This is actually the country code.
-- Year -> In which year, the athlete has participated
-- Sport -> What is the sport name in which the athlete participated.
-- Event -> Event name of the sport
-- Medal -> Which medal the athlege got. If the athlete did not get any medal then this cell is blank.
-- country -> The name of the country.
-- Problem 1
-- Display the names of athletes who won a gold medal in the 2008 Olympics and whose height is greater than the average height of all athletes in the 2008 Olympics.
select * from olympic where year = 2008 and Medal = 'Gold' and Height > (select avg(Height) from olympic where Year = 2008);
-- Problem 2
-- Display the names of athletes who won a medal in the sport of basketball in the 2016 Olympics and whose weight is less than the average weight of all athletes who won a medal in the 2016 Olympics.
select name from olympic where Year = 2016 and 
Sport = 'BasketBall'
and Medal is not null and
height < (select avg(Height) from olympic where Year = 2016 AND Medal is not null);
-- Problem 3
-- Display the names of all athletes who have won a medal in the sport of swimming in both the 2008 and 2016 Olympics.
select * from olympic where Sport = 'Swimming' and Year in (2008,2016) and Medal is not null;
select distinct(Sport) from olympic;
-- Problem 4
-- Display the names of all countries that have won more than 50 medals in a single year.
select country, Year, count(*) from olympic
WHERE Medal is not null and country is not null
group by country,Year
having count(*) > 50
order by Year, country;

-- Problem 5
-- Display the names of all athletes who have won medals in more than one sport in the same year.
select * from olympic where Medal is not null
group by ID, Year, Sport;
-- Problem 6
-- What is the average weight difference between male and female athletes in the Olympics who have won a medal in the same event?
select Sex, count(*) from olympic 
group by Sex;
---------------------------------------------------------------------------------------------------------------------------------------------------------





use sql_tasks;
select * from sql_tasks.insurance_data;
-- Problem 7
-- How many patients have claimed more than the average claim amount for patients who are smokers and have at 
-- least one child, and belong to the southeast region?
select count(claim) from sql_tasks.insurance_data 
where claim>(select avg(claim) from sql_tasks.insurance_data 
			  where smoker = 'Yes' 
              and children >= 1 
              and region = 'southeast');

-- Problem 8
-- How many patients have claimed more than the average claim amount for patients who are not smokers and have a
--  BMI greater than the average BMI for patients who have at least one child?

select count(*) from sql_tasks.insurance_data where claim > (select avg(claim) from sql_tasks.insurance_data
where smoker = 'No' and 
bmi>(select avg(bmi) from sql_tasks.insurance_data where children>=1));

-- Problem 9
-- How many patients have claimed more than the average claim amount for patients who have a BMI greater than 
-- the average BMI for patients who are diabetic, have at least one child, and are from the southwest region?
select count(*) from sql_tasks.insurance_data where claim > (select avg(claim) 
															 from sql_tasks.insurance_data 
                                                             where bmi > (select avg(bmi) from sql_tasks.insurance_data
                                                             where children >= 1 and region = 'southwest'));

-- Problem 10:
-- What is the difference in the average claim amount between patients who are smokers and patients who are non-smokers, 
-- and have the same BMI and number of children? 
select AVG(A.claim - B.claim) as 'claim_diff_btwn_patients_on_Different_criterias' from sql_tasks.insurance_data A 
join sql_tasks.insurance_data B 
on A.bmi = B.bmi 
and A.smoker != B.smoker 
and A.children = B.children;








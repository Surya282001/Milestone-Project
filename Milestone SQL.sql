drop database salary_survey;
Use mile;

select*from Salary;

/*1. Average Salary by Industry and Gender */
Select Industry, Gender,Round(Avg(Annual_salary),2) As Avg_Salary
From Salary
Group by Industry,Gender
Order By  AVG_Salary DESC;

/*2. Total Salary Compensation by Job Title*/

Select Job_title,Sum(Additional_Monetary_Compensation) As Total_Compensation
From Salary
group By job_title
Order by Total_Compensation DESC;

/*3. Salary Distribution by Education Level*/

Select Qualification,Round(
	Avg(Annual_Salary),2) As Avg_Salary,
    Min(Annual_Salary) As Min_Salary,
    Max(Annual_Salary) As Max_Salary,
    abs(min(annual_salary)-max(annual_Salary)) As Distribution
From salary
Group by Qualification
Order by Avg_Salary DESC ;

/*4. Number of Employees by Industry and Years of Experience*/

Select Industry,Professional_Experience,Count(Age_range) As Num_Employees
From salary
Group by Industry,Professional_Experience
Order by Num_employees DESC;


/*5. Median Salary by Age Range and Gender*/

With RankedSalaries As(
Select Annual_Salary,Age_Range,Gender,
Row_Number() Over (Partition By Age_Range,Gender) As Row_Num,
Count(*) over (Partition by Age_Range,gender) As Total_Count
From Salary
)
Select Age_Range,Gender,
CASE
When Total_Count % 2=1 then 
MAX(CASE WHEN Row_Num=(Total_Count+1)/2 Then Annual_Salary End)
Else
Avg(CASE When Row_Num In(Total_Count/2,Total_Count/2+1) Then Annual_Salary End)
End As Median_Salary
From RankedSalaries
Group by Age_Range,Gender
Order by Median_Salary DESC;



/*6. Job Titles with the Highest Salary in Each Country*/

Select Country,Job_Title, Max(Annual_Salary) As Highest_Salary
From Salary
Group by Job_Title,Country
Order by Highest_Salary DESC;


/*7. Average Salary by City and Industry*/

Select City,Industry, Avg(annual_Salary) As Avg_Salary
From salary
Group by city,industry
Order by Avg_Salary DESC;

/*8. Percentage of Employees with Additional Monetary Compensation by Gender*/

select gender,
	Round(((count( case when additional_monetary_compensation>0 then Age_Range 
	end)/count(age_range))*100),2) as Percentage_of_Employees 
	fROM salary 
Group By Gender;

/*9. Total Compensation by Job Title and Years of Experience */

Select Job_Title,Professional_Experience,
Sum(Additional_Monetary_Compensation) As Total_Compensation
From Salary
Group by Professional_Experience,Job_Title
Order by Total_Compensation DESC;


/*10. Average Salary by Industry, Gender, and Education Level*/

Select Industry,Gender,Qualification,Avg(Annual_Salary) As Avg_Salary
From Salary
Group By Industry,Gender,Qualification
Order by  Avg_Salary DESC ;



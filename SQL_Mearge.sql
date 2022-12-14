use SQL_PROJECTS

SELECT * FROM  old_info

create table new_info1(Emp_no int,E_gender varchar(20),E_JobRole varchar(50))


MERGE INTO new_info1 AS TARGET
USING old_info AS source
ON (TARGET.Emp_no=source.EmployeeNumber)


WHEN not matched BY TARGET -- for insert
THEN
insert (Emp_no,E_Gender,E_JobRole)
values (source.employeeNumber,source.gender,source.JobRole)

WHEN matched THEN   -- for update
update set target.E_gender=source.gender,
target.E_JobRole=source.JobRole,
TARGET.Emp_no=source.EmployeeNumber

WHEN NOT MATCHED BY SOURCE -- for delete
THEN DELETE;



select * from old_info
select * from new_info1



-- SELECT * from new_info1 where E_gender='male' and E_JobRole='developer'

-- INSERT INTO old_info values 
-- (56,0,'Non_Travel',950,'Finance',45,4,'other',1,10,3,'Female',67,2,5,'Accountant',4,'single',35000,353948,3,'Y',0,15,2,3,80,4,7,3,4,12,8,4,2)

-- INSERT INTO new_info1 values (10,'Male','Sales Executive')

-- delete new_info1 where Emp_no=10 and E_gender='Female' and E_JobRole='Sales Executive'


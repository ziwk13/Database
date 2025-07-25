drop database if exists db;
create database if not exists db;

use db;

CREATE TABLE IF NOT EXISTS tbl_department (
    dept_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(30) NOT NULL,
    location VARCHAR(50) NULL
)  ENGINE=INNODB;
create table if not exists tbl_employee (
emp_id int not null auto_increment primary key,
dept_id int null,
emp_name varchar(15) not null,
position varchar(10) null,
gender varchar(1) null,
hire_date date not null default(current_date),
salary int null,
foreign key(dept_id) references tbl_department(dept_id)
on delete set null
) engine=innodb;

alter table tbl_employee auto_increment = 1001;

insert into tbl_department (dept_name, location)
values ("영업부", "대구"),
       ("인사부", "서울"),
       ("총무부", "대구"),
       ("기획부", "서울");

insert into tbl_employee (dept_id, emp_name, position, gender, hire_date, salary)
values (1, "구창민", "과장", "M", "1995-05-01", 5000000),
       (1, "김민서", "사원", "M", "2017-09-01", 2500000),
       (2, "이은영", "부장", "F", "1990-09-01", 5500000),
       (2, "한성일", "과장", "M", "1993-04-01", 5000000);
       


drop table if exists tbl_department;

drop table if exists tbl_employee;

select * from tbl_department;
select * from tbl_employee;

insert into tbl_department (dept_name, location)
values ("개발부", "서울");

update tbl_department
set dept_name = "총무부"
where location = "부산"; 


delete
from tbl_department
where dept_id = 4;


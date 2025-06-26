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

SELECT 
    *
FROM
    tbl_department;
SELECT 
    *
FROM
    tbl_employee;

insert into tbl_department (dept_name, location)
values ("개발부", "서울");

UPDATE tbl_department 
SET 
    dept_name = '총무부'
WHERE
    location = '부산'; 


DELETE FROM tbl_department 
WHERE
    dept_id = 4;

/*
TCL
1. 작업 저장
  COMMIT;
2. 작업 취소 (이전 작업 저장 시점으로 되돌아 감)
  ROLLBACK;
  
트랜잭션(Transaction)
1. 하나의 작업을 의미 한다.
2. 하나 이상의 쿼리문(DML) 으로 구성 된다.

커밋 이전 상황
1. 메모리(휘발성 기억장치)에 정보를 저장 한다.
2. undo log에 임시로 정보가 저장 된다.
3. 롤백이 가능 하다.

커밋 이후 상황
1. 디스크(비휘발성 기억장치)에 영구적으로 정보를 저장 한다.
2. 롤백이 불가능 하다.
*/


# autocommit 여부를 확인 하는 쿼리문 (0이면 autocommit 아님, 1이면 autocommit 상태)
SELECT @@autocommit;

# autocommit 상태를 바꾸는 쿼리문
set autocommit = 0;

# 트랜잭션의 범위를 설정 하는 방법
# START TARNSACTION;
# 쿼리문1
# 쿼리문2
# ...
# COMMIT;

# autocommit 테스트
insert into tbl_department ( dept_name, location )
values ("개발부", "인천");

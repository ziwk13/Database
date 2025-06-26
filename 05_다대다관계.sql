# 학생 테이블    과목 테이블
# 1               M (학생 1명이 여러 과목을 배운다.)
# M               1 (과목 1개를 여러 학생이 배운다.)
# M               M (일대다 관계가 모두 성립하는 경우 다대다 관계 이다. 다대다 관계는 두 테이블을 직접 관계 지을 수 없다.)

# 다대다 관계는 일대다 관계 2개로 구성 한다.
# 일대다 관계 2개를 구성 하려면 테이블이 3개가 필요 하다.

# 학생 테이블   수강 현황 테이블   과목 테이블
# 1             1, M 모두 작성     M
# M             M, 1 모두 작성     1
# PK            FK
#               FK                 PK
# 부모(parent)  자식(child)        부모(parent)

# 데이터베이스 생성
create database if not exists db_model;

# 데이터베이스 사용
use db_model;

# 학생 테이블 생성 (PK)
CREATE TABLE IF NOT EXISTS tbl_student (
    student_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(10) NOT NULL,
    phone_number CHAR(11) NOT NULL,
    email VARCHAR(100) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)  ENGINE=INNODB;

# 과목 테이블 생성 (PK)
create table if not exists tbl_subject (
subject_id int not null auto_increment primary key,
title varchar(50) not null,
credit tinyint not null,
created_at timestamp default current_timestamp
) engine=InnoDB;

# 수강 현황 테이블 생성 (PK)
CREATE TABLE IF NOT EXISTS tbl_enrollment (
    enrollment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    stud_id INT NOT NULL,
    subj_id INT NOT NULL,
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (stud_id)
        REFERENCES tbl_student (student_id)
        ON DELETE CASCADE,
    FOREIGN KEY (subj_id)
        REFERENCES tbl_subject (subject_id)
        ON DELETE CASCADE,
    UNIQUE KEY (stud_id , subj_id)
)  ENGINE=INNODB;

# 수강 현황 삭제
drop table if exists tbl_enrollment;

# 과목 테이블 삭제
drop table if exists tbl_subject;

# 학생 테이블 삭제
drop table if exists tbl_student;

# db_model 데이터베이스 삭제
drop database if exists db_model;
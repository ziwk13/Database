/*
문제. 계좌 이체 처리하기

1. db_bank 데이터베이스와 은행, 고객, 계좌 테이블을 생성합니다.
  1) 관계 설정
    (1) 은행과 고객은 다대다 관계입니다.
    (2) 하나의 은행에는 여러 개의 계좌 정보가 존재합니다.
    (3) 하나의 고객은 여러 개의 계좌를 가질 수 있습니다.
  2) 칼럼 설정
    (1) 은행: 은행 아이디, 은행 이름
    (2) 고객: 고객 아이디, 고객 이름, 고객 연락처
    (3) 계좌: 계좌 아이디, 잔고 등
  3) 레코드 설정 (행 설정)
    (1) 각 테이블에 최소 2개의 샘플 데이터를 입력합니다.
    (2) 100,000원 이상의 잔고를 가지도록 입력합니다.
2. 계좌 이체 트랜잭션을 처리합니다.
  1) 1번 고객이 2번 고객으로 100,000원을 계좌 이체하는 트랜잭션을 작성하고 실행합니다.
  2) 쿼리문 실행 중 발생하는 오류는 없다고 가정하고 ROLLBACK 처리는 하지 않습니다.
*/


create database if not exists db_bank;

use db_bank;

CREATE TABLE IF NOT EXISTS tbl_bank (
    bank_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    bank_name VARCHAR(50) NOT NULL
)  ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS tbl_user (
    user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(25) NOT NULL,
    user_phone VARCHAR(25) NULL
)  ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS tbl_account (
    account_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    bank_id INT NOT NULL,
    user_id INT NOT NULL,
    balance DECIMAL(15 , 2 ) NOT NULL,
    FOREIGN KEY (bank_id)
        REFERENCES tbl_bank (bank_id)
        ON DELETE CASCADE,
    FOREIGN KEY (user_id)
        REFERENCES tbl_user (user_id)
        ON DELETE CASCADE
)  ENGINE=INNODB;

insert into tbl_bank(bank_name)
values ("국민"),
       ("신한");

insert into tbl_user(user_name, user_phone)
values ("김김김", "00100010000"),
       ("님님님", "12345678901");
       
insert into tbl_account(bank_id, user_id, balance)
values (1, 1, 500000),
       (2, 2, 100000);
       
SELECT 
    *
FROM
    tbl_bank;
SELECT 
    *
FROM
    tbl_user;
SELECT 
    *
FROM
    tbl_account;
       
commit;

SELECT @@autocommit;

start transaction;

UPDATE tbl_account 
SET 
    balance = balance - 100000
WHERE
    account_id = 1;

UPDATE tbl_account 
SET 
    balance = balance + 100000
WHERE
    account_id = 2;


drop table tbl_bank;
drop table tbl_user;
drop table tbl_account;









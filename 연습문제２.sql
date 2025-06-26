# db_product 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS db_product;

# db_product 데이터베이스 사용
USE db_product;

# 새로운 테이블 생성 이전 기존 테이블 정리 (삭제는 생성의 역순으로 진행)
DROP TABLE IF EXISTS tbl_buy;
DROP TABLE IF EXISTS tbl_product;
DROP TABLE IF EXISTS tbl_user;

# tbl_user 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_user (
    user_no      INT NOT NULL AUTO_INCREMENT COMMENT "사용자번호"
  , user_id      VARCHAR(20) NOT NULL UNIQUE COMMENT "사용자아이디"  -- UNIQUE: 중복 불가능 제약조건 입니다.
  , user_name    VARCHAR(20) NULL COMMENT "사용자명"
  , user_year    SMALLINT NULL COMMENT "태어난년도"
  , user_addr    VARCHAR(100) NULL COMMENT "주소"
  , user_mobile1 VARCHAR(3) NULL COMMENT "연락처1(010)"
  , user_mobile2 VARCHAR(8) NULL COMMENT "연락처2(12345678)"
  , create_date  DATE NULL DEFAULT (CURRENT_DATE) COMMENT "등록일"
  , CONSTRAINT pk_user PRIMARY KEY(user_no)  -- PK를 별도로 등록하면서 PK 제약조건의 이름을 pk_user로 지정하였습니다.
) ENGINE=InnoDB COMMENT "사용자";

# tbl_product 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_product (
    prod_code  INT NOT NULL AUTO_INCREMENT COMMENT "상품코드"
  , prod_name  VARCHAR(20) NULL COMMENT "상품명"
  , category   VARCHAR(20) NULL COMMENT "상품카테고리"
  , prod_price INT NULL COMMENT "상품가격"
  , CONSTRAINT pk_product PRIMARY KEY(prod_code)  -- PK를 별도로 등록하면서 PK 제약조건의 이름을 pk_product으로 지정하였습니다.
) ENGINE=InnoDB COMMENT "상품";

# tbl_buy 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_buy (
    buy_no     INT NOT NULL AUTO_INCREMENT COMMENT "구매번호"
  , user_no    INT NULL COMMENT "사용자번호"
  , prod_code  INT NULL COMMENT "상품코드"
  , buy_amount INT NOT NULL DEFAULT 1 COMMENT "구매수량"
  , CONSTRAINT pk_buy PRIMARY KEY(buy_no)
  , CONSTRAINT fk_user_buy FOREIGN KEY(user_no) REFERENCES tbl_user(user_no) 
      ON DELETE CASCADE
  , CONSTRAINT fk_prod_buy FOREIGN KEY(prod_code) REFERENCES tbl_product(prod_code) 
      ON DELETE SET NULL
) ENGINE=InnoDB COMMENT "구매";

# tbl_user 데이터 등록
INSERT INTO tbl_user 
VALUES (NULL, "YJS", "유재석", 1972, "서울", "010", "11111111", "08-08-08"),
       (NULL, "KHD", "강호동", 1970, "경북", "011", "22222222", "07-07-07"),
       (NULL, "KKJ", "김국진", 1965, "서울", "010", "33333333", "09-09-09"),
       (NULL, "KYM", "김용만", 1967, "서울", "010", "44444444", "15-05-05"),
       (NULL, "KJD", "김제동", 1974, "경남", NULL, NULL, "13-03-03"),
       (NULL, "NHS", "남희석", 1971, "충남", "010", "55555555", "14-04-04"),
       (NULL, "SDY", "신동엽", 1971, "경기", NULL, NULL, "08-10-10"),
       (NULL, "LHJ", "이휘재", 1972, "경기", "011", "66666666", "06-04-04"),
       (NULL, "LKK", "이경규", 1960, "경남", "011", "77777777", "04-12-12"),
       (NULL, "PSH", "박수홍", 1970, "서울", "010", "88888888", "12-05-05");

# tbl_product 데이터 등록
INSERT INTO tbl_product 
VALUES (NULL, "운동화", "신발", 30),
       (NULL, "청바지", "의류", 50),
       (NULL, "책", "잡화", 15),
       (NULL, "노트북", "전자", 1000),
       (NULL, "모니터", "전자", 200),
       (NULL, "메모리", "전자", 80),
       (NULL, "벨트", "잡화", 30);

# tbl_buy 데이터 등록
INSERT INTO tbl_buy 
VALUES (NULL, 2, 1, 2),
       (NULL, 2, 4, 1),
       (NULL, 4, 5, 1),
       (NULL, 10, 5, 5),
       (NULL, 2, 2, 3),
       (NULL, 10, 6, 10),
       (NULL, 5, 3, 5),
       (NULL, 8, 3, 2),
       (NULL, 8, 2, 1),
       (NULL, 10, 1, 2);

############################## 문 제 ##############################

# 1. 연락처1이 없는 사용자의 사용자번호, 아이디, 연락처1, 연락처2를 조회하세요.
/*
    user_no  user_id  user_mobile1  user_mobile2
    5        KJD      NULL          NULL
    7        SDY      NULL          NULL
*/
select
user_no, user_id, user_mobile1, user_mobile2
from tbl_user
where user_mobile1 is null;

# 2. 연락처2가 "5"로 시작하는 사용자의 사용자번호, 아이디, 연락처1, 연락처2를 조회하세요.
/*
    user_no  user_id  user_mobile1  user_mobile2
    6        NHS      010           55555555
*/
select 
user_no, user_id, user_mobile1, user_mobile2
from tbl_user
where user_mobile2 like "5%";

# 3. 2010년 이후에 가입한 사용자의 사용자번호, 아이디, 가입일을 조회하세요.
/*
    user_no  user_id  create_date
    4        KYM      2015-05-05
    5        KJD      2013-03-03
    6        NHS      2014-04-04
    10       PSH      2012-05-05
*/
select
user_no, user_id, create_date
from tbl_user
where create_date >= '2010-01-01';

# 4. 사용자번호와 연락처1, 연락처2를 연결하여 조회하세요. 
# 연락처가 없는 경우 NULL 대신 "None"으로 조회하세요.
/*
    user_no  contact
    1        01011111111
    2        01022222222
    3        01033333333
    4        01044444444
    5        None
    6        01055555555
    7        None
    8        01066666666
    9        01077777777
    10       01088888888
*/
select * from tbl_user;
select
user_no, ifnull(concat(user_mobile1, user_mobile2),"None")
from tbl_user;


# 5. 지역별 사용자수를 조회하세요.
/*
    주소   사용자수
    서울   4
    경북   1
    경남   2
    충남   1
    경기   2
*/
select 
user_addr as 주소
, count(user_addr) as 사용자수
from tbl_user
group by user_addr;

# 6. "서울", "경기"를 제외한 지역별 사용자수를 조회하세요.
/*
    주소   사용자수
    경북   1
    경남   2
    충남   1
*/
select 
user_addr as 주소
, count(user_addr) as 사용자수
from tbl_user
group by user_addr
having user_addr not in ("서울", "경기");

# 7. 구매내역이 없는 사용자를 조회하세요.
/*
    번호  아이디
    3     KKJ
    9     LKK
    6     HNS
    7     SDY
    1     YJS
*/
select
u.user_no as 번호,
u.user_id as 아이디
from tbl_user u
left outer join tbl_buy b on u.user_no = b.user_no
where b.user_no is null;

# 8. 카테고리별 구매횟수를 조회하세요.
/*
    카테고리  구매횟수
    신발      2
    의류      2
    서적      2
    전자      4
*/
select
p.category as 카테고리,
count(b.prod_code) as 구매횟수
from tbl_product p
join tbl_buy b on p.prod_code = b.prod_code
group by p.category;

# 9. 아이디별 구매횟수를 조회하세요.
# 구매한 적이 없는 아이디는 조회하지 마세요.
/*
    아이디  구매횟수
    KHD     3
    KYM     1
    KJD     1
    LHJ     2
    PSH     3
*/
select
u.user_id as 아이디,
count(b.user_no) as 구매횟수
from tbl_user u
join tbl_buy b on u.user_no = b.user_no
group by u.user_id;

# 10. 아이디별 구매횟수를 조회하세요. 
# 구매 이력이 없는 경우 구매횟수는 0으로 조회하고 아이디의 오름차순으로 조회하세요.
/*
    아이디  고객명  구매횟수
    KHD     강호동  3
    KJD     김제동  1
    KKJ     김국진  0
    KYM     김용만  1
    LHJ     이휘재  2
    LKK     이경규  0
    NHS     남희석  0
    PSH     박수홍  3
    SDY     신동엽  0
    YJS     유재석  0
*/
select
u.user_id as 아이디,
u.user_name as 이름,
count(b.buy_no) as 구매횟수
from tbl_user u
left outer join tbl_buy b on u.user_no = b.user_no
group by u.user_no
order by u.user_id;

# 11. 모든 상품의 상품명과 판매횟수를 조회하세요. 판매 이력이 없는 상품은 0으로 조회하세요.
/*
    상품명  판매횟수
    운동화  2개
    청바지  2개
    책      2개
    노트북  1개
    모니터  2개
    메모리  1개
    벨트    0개
*/
select
p.prod_name as 상품명,
count(b.prod_code) as 판매횟수
from tbl_product p
left outer join tbl_buy b on p.prod_code = b.prod_code
group by p.prod_name;


# 12. 카테고리가 "전자"인 상품을 구매한 고객의 구매내역을 조회하세요.
/*
    고객명  상품명  구매액
    강호동  노트북  1000
    김용만  모니터  200
    박수홍  모니터  1000
    박수홍  메모리  800
*/
select
u.user_name as 고객명,
p.prod_name as 상품명,
(p.prod_price * b.buy_amount) as 구매액
from tbl_user u
join tbl_buy b on u.user_no = b.user_no
join tbl_product p on b.prod_code = p.prod_code
where p.category = "전자";

# 13. 상품을 구매한 이력이 있는 고객의 아이디, 고객명, 구매횟수, 총구매액을 조회하세요.
/*
    아이디  고객명  구매횟수  총구매액
    KHD     강호동  3         1210
    KYM     김용만  1         200
    PSH     박수홍  3         1860
    KJD     김제동  1         75
    LHJ     이휘재  2         80
*/
select
u.user_id as 아이디,
u.user_name as 고객명,
count(b.buy_amount) as 구매횟수,
sum(b.buy_amount * p.prod_price) as 총구매액
from tbl_user u
join tbl_buy b on u.user_no = b.user_no
join tbl_product p on b.prod_code = p.prod_code
group by u.user_no;

# 14. 구매횟수가 2회 이상인 고객명과 구매횟수를 조회하세요.
/*
    고객명  구매횟수
    강호동  3
    이휘재  2
    박수홍  3
*/
select
u.user_name as 고객명,
count(u.user_no) as 구매횟수
from tbl_user u
join tbl_buy b on u.user_no = b.user_no
group by u.user_no
having count(b.user_no) >= 2;


# 15. 어떤 고객이 어떤 상품을 구매했는지 조회하세요. 
# 구매 이력이 없는 고객도 조회하고 아이디로 오름차순 정렬하세요.
/*
    고객명   구매상품
    강호동   청바지
    강호동   노트북
    강호동   운동화
    김제동   책
    김국진   NULL
    김용만   모니터
    이휘재   청바지
    이휘재   책
    이경규   NULL
    남희석   NULL
    박수홍   운동화
    박수홍   메모리
    박수홍   모니터
    신동엽   NULL
    유재석   NULL
*/
select
u.user_name as 고객명,
p.prod_name as 구매상품
from tbl_user u
left outer join tbl_buy b on u.user_no = b.user_no
left outer join tbl_product p on b.prod_code = p.prod_code
order by u.user_id;


# 16. 상품 테이블에서 상품명이 "책"인 상품의 카테고리를 "서적"으로 수정하세요.


# 17. 연락처1이 "011"인 사용자의 연락처1을 모두 "010"으로 수정하세요.


# 18. 구매번호가 가장 큰 구매내역을 삭제하세요.
# MySQL은 UPDATE/DELETE 문에서 자기 자신의 테이블 데이터를 직접 사용할 수 없습니다. 
# (Error Code: 1093.)
# 아래와 같은 형식의 쿼리문은 오류가 발생합니다.
DELETE
  FROM tbl_buy
 WHERE buy_no = (SELECT MAX(buy_no)
                   FROM tbl_buy);

# 최대 구매번호를 구할 때 서브쿼리를 하나 더 활용해서 해결해 보세요.


# 19. 상품코드가 1인 상품을 삭제하세요. 
# 삭제 이후 상품번호가 1인 상품의 구매내역을 조회하세요.
# 1) 삭제

# 2) 삭제 후 구매내역 조회


# 20. 사용자번호가 5인 사용자를 삭제하세요. 
# 사용자번호가 5인 사용자의 구매 내역을 먼저 삭제한 뒤 진행해야 합니다.
# 1) 사용자 삭제

# 2) 구매 내역 삭제
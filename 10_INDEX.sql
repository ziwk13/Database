# db 데이터베이스 사용
use db;

/*
  클러스터 인덱스
  1. Primary Index 이다.
  2. 테이블에 1개만 존재 할 수 있다.
  3. PK로 설정된 칼럼은 클러스터 인덱스를 자동으로 가진다.
*/

# 부서 아이디가 1인 부서 조회하기 : 인덱스 태우기 성공
explain
select
dept_id as 부서아이디,
dept_name, location
from tbl_department
where dept_id = 1; -- 인덱스가 설정된 칼럼을 WHERE 절에서 사용
# 결과
# type = const : PK 또는 UK WHERE 절에서 상수 값과 비교하여 항상(const) 하나의 행만 반환하는 접근 방식
# rows = 1     : MySQL이 검사할 것으로 예상되는 행의 수

# 부서 아이디가 1인 부서 조회하기 : 인덱스 태우기 실패
explain
select
dept_id as 부서아이디,
dept_name, location
from tbl_department
where dept_id * 2 = 2; -- 인덱스가 설정된 칼럼을 조작하면 (연산, 함수 등) 더 이상 인덱스를 타지 않는다.
# 결과
# type = ALL : 테이블의 모든 행을 처음 부터 모두 읽는 Full Table Scan 방식 ( 가장 안 좋은 방식)
# rows = 5   : MySQL이 검사할 것으로 예상되는 행의 수 (전체 행의 수)

# 부서 아이디가 1 이상인 부서 조회 하기
explain
select
dept_id as 부서아이디,
dept_name, location
from tbl_department
where dept_id >= 1; -- MySQL이 Index Range Scan 또는 Full Table Scan 중 선택해서 동작 한다.
#결과
# type = range : Index Range Scan 실시 ( 비교적 효율적인 방법)
# row = 5      : MySQL이 검사할 것으로 예상되는 행의 수 (전체 행의 수)

/*
  논-클러스터 인덱스
  1. Secondary Index 이다.
  2. 테이블에 1개 이상 존재 할 수 있다.
  3. UNIQUE로 설정된 칼럼 또는 CREATE INDEX 문을 이용 해서 설정 한다.
*/

# 보조 인덱스 생성
create index ix_name
  on tbl_employee(emp_name ASC);  -- 직원 테이블의 직원명 칼럼에 인덱스를 설정
  
# 직원명이 "이은영"인 직원 정보 조회 하기
explain
select emp_id, dept_id, emp_name, position, gender, hire_date, salary
from tbl_employee
where emp_name = "이은영";
# 결과
# type = ref : 비고유 인덱스(Non Unique)의 동등 비교(=)에서 나타나는 방식 ( 여러 행을 찾는 효율적 방식)
# row = 1    : MySQL이 검사할 것으로 예상되는 행의 수

# 성이 "이"인 직원 정보 조회 하기 (2가지 방법 비교해 보기)
# 1. Index Eange Scan
explain
select emp_id, dept_id, emp_name, position, gender, hire_date, salary
from tbl_employee
where emp_name LIKE "이%";
# 2. Full Table Scan
explain
select emp_id, dept_id, emp_name, position, gender, hire_date, salary
from tbl_employee
where substring(emp_name, 1, 1) =  "이";
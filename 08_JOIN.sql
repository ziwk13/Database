# db 데이터베이스 사용
use db;

/*
 Cross Join
  1. 조인 조건이 생략 되거나, 잘못된 조인 조건을 사용 한 경우.
  2. 조인 하는 테이블들의 모든 행들을 조합 하여 조회 한다.
*/

# 부서번호, 부서명, 직원번호, 직원명 Cross Join 으로 조회 하기

SELECT 
    d.dept_id, d.dept_name, e.emp_id, e.emp_name
FROM
    tbl_department d
        CROSS JOIN
    tbl_employee e; 

/*
  Inner Join
  1. 조인 조건을 지정하는 조회 방식 이다.
  2. 조인하는 두 테이블에 존재하는 데이터를 대상으로 조회 한다.
  
  Join Table 구분
  1. Drive Table
    1) 조인을 주동하는 테이블
    2) PK를 가진 테이블
    3) 일반적으로 행(Row)이 적은 테이블
  2. Driven Table
    1) Drive Table에 의해서 참조되는 테이블
    2) FK를 가진 테이블
    3) 일반적으로 행(Row)이 많은 테이블
    
  Optimizer(옵티마이저)
  1. 어떤 테이블을 Drive Table로 사용 할 것인지 선택 한다.
  2. 테이블 크기, 인덱스 유무, 조건절의 선택도(조건 필터링 결과가 적을 것으로 예상 되는 테이블을 Drive Table로 선정)
  등을 이용해서 Drive Table을 선택 한다.
  3. 과거 DB는 FROM 절에 작성한 테이블을 Drive Table로 인식 하기도 했다.
*/

# 모든 직원들의 부서아이디, 부서명, 직원 아이디, 직원명을 조회하기
SELECT 
    d.dept_id, d.dept_name, e.emp_id, e.emp_name
FROM
    tbl_department d
        INNER JOIN
    tbl_employee e ON d.dept_id = e.dept_id;  -- 두 테이블의 참조 관계를 찾아서 이를 조인 조건으로 사용 한다.
    
# EXPLAIN을 이용한 쿼리 실행 계획 확인 하기
EXPLAIN SELECT 
    d.dept_id, d.dept_name, e.emp_id, e.emp_name
FROM
    tbl_department d
        INNER JOIN
    tbl_employee e ON d.dept_id = e.dept_id;
    
/*
  Outer Join
  1. 조인 조건을 만족하지 않는 데이터를 결과에 포함시키는 조인 방식
  2. 어느 한 쪽 테이블의 모든 데이터는 항상 결과에 포함 된다.
  3. 어느 쪽 테이블의 모든 데이터를 항상 포함 할지에 따라 다음 세 가지로 나뉜다.
   1) LEFT OUTER JOIN : JOIN 절 왼쪽에 있는 테이블의 모든 데이터를 항상 조회 된다.
   2) RIGHT OUTER JOIN: JOIN 절 오른쪽에 있는 테이블의 모든 데이터를 항상 조회 된다.
   3) FULL OUTER JOIN : JOIN 절 양쪽에 있는 테이블의 모든 데이터를 항상 조회 된다.
*/
# 모든 직원들의 부서아이디, 부서명, 직원 아이디, 직원명을 조회하기
# 단, 직원이 그눔하지 않는 부서 정보도 조회 하기
select d.dept_id, d.dept_name, e.emp_id, e.emp_name
from tbl_department d
left outer join tbl_employee e
on d.dept_id = e.dept_id;

# 모든 직원들의 부서아이디, 부서명, 직원 아이디, 직원명을 조회하기
# 단, 부서가 없는 직원 정보도 조회 하기
select d.dept_id, d.dept_name, e.emp_id, e.emp_name
from tbl_department d
right outer join tbl_employee e
on d.dept_id = e.dept_id;

# 1. "서울"에 근무하는 직원 정보 조회 하기
SELECT 
    emp_id, e.dept_id, emp_name, position, gender, hire_date, salary
FROM
    tbl_department d
        JOIN
    tbl_employee e ON d.dept_id = e.dept_id
WHERE
    d.location = '서울';

# 2. 급여를 5,000,000 이상 받는 직원이 있는 부서 정보 조회 하기
SELECT DISTINCT
    d.dept_id, dept_name, location
FROM
    tbl_department d
        JOIN
    tbl_employee e ON d.dept_id = e.dept_id
WHERE
    e.salary >= 5000000;

# 3. 각 지역별로 근무하는 직원 수 조회 하기 (근무 중인 직원이 없으면 조회할 필요 없음)
SELECT 
    d.location, COUNT(e.emp_id)
FROM
    tbl_department d
        JOIN
    tbl_employee e ON d.dept_id = e.dept_id
GROUP BY d.location;

# 4. 각 부서별 직원 수 조회 하기 (근무 중인 직원이 없으면 0으로 표시하기)
SELECT 
    d.dept_name, COUNT(e.emp_id)
FROM
    tbl_department d
        LEFT OUTER JOIN
    tbl_employee e ON d.dept_id = e.dept_id
GROUP BY d.dept_id;
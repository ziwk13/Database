/*
  서브 쿼리
  1. 쿼리 내부에 다른 쿼리를 포함 하는 것을 의미 한다.
  2. 쿼리가 포함되는 절에 따라 종류를 구분 한다.
  3. 종류
    1) WHERE 절 : 중첩 서브쿼리(단일 행 서브쿼리, 다중 행 서브쿼리)
    2) FROM 절  : 인라인 뷰(테이블 형식의 결과 반환)
    3) SELECT 절: 스칼라 서브쿼리
*/

use db;

# 직원 아이디가 1001인 직원과 같은 직급의 직원 정보 조회 하기
SELECT 
    emp_id,
    dept_id,
    emp_name,
    position,
    gender,
    hire_date,
    salary
FROM
    tbl_employee
WHERE
    position = (SELECT 
            position
        FROM
            tbl_employee
        WHERE 
            emp_id = 1001); -- 단일 행 서브쿼리 (단일 행 연산자 : =, !=, <, <=, >, >=)
            
# 평균 급여 이상을 받는 직원 정보 조회 하기
SELECT 
    emp_id,
    dept_id,
    emp_name,
    position,
    gender,
    hire_date,
    salary
FROM
    tbl_employee
WHERE
    salary >= (SELECT 
            AVG(salary)
        FROM
            tbl_employee); -- 단일 행 서브쿼리

# "영업부"에 근무하는 직원 정보 조회 하기
SELECT 
    emp_id,
    dept_id,
    emp_name,
    position,
    gender,
    hire_date,
    salary
FROM
    tbl_employee
WHERE
    dept_id IN (SELECT 
            dept_id
        FROM
            tbl_department
        WHERE
            dept_name = '총무부' OR dept_name = '인사부'); -- 다중 행 서브쿼리 (다중 행 연산자 : IN, ANY, ALL 등)
            
# 부서별급여 평균 중에서 가장 높은 급여 평균 구하기
SELECT 
    a.dept_name, MAX(a.avg(e.salary))
FROM
    (SELECT 
        d.dept_name AS deptname, 
        AVG(e.salary) AS average  -- 인라인 뷰의 컬럼에 별칭을 주고, 메인쿼리에서 별칭을 사용
    FROM
        tbl_department d
    INNER JOIN tbl_employee e ON d.dept_id = e.dept_id
    GROUP BY d.dept_id , d.dept_name) a;
    
    SELECT 
    emp_id,
    dept_id,
    emp_name,
    position,
    gender,
    hire_date,
    salary,
    (SELECT 
            AVG(salary)
        FROM
            tbl_employee)
FROM
    tbl_employee
WHERE
    emp_id = 1003;

/*
  상관 서브쿼리 (Correlated Subquery)
  1. 서브쿼리가 메인쿼리의 값을 참조 하는 방식의 쿼리 입니다.
  2. 서브쿼리가 메인쿼리의 각 행마다 한 번씩 실행 되고, 메이누커리의 값을 서브쿼리에서 사용 한다.
*/

# 직원 정보와 부서명을 함께 조회 하기
SELECT 
    emp_id,
    dept_id,
    emp_name,
    position,
    gender,
    hire_date,
    salary,
    (SELECT 
            dept_name
        FROM
            tbl_department
        WHERE
            dept_id = e.dept_id)
FROM
    tbl_employee e;
    
# 직원 정보와 해당 직원이 속한 부서의 급여 평균을 함게 조회하기
select
    emp_id,
    dept_id,
    emp_name,
    position,
    gender,
    hire_date,
    salary,
    (select avg(salary) from tbl_employee where dept_id = e.dept_id) as "급여평균"
from tbl_employee e;
    
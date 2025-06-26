/*
  뷰
  1. 행과 열로 구성된 테이블
  2. 데이터를 저장 하지는 않기 때문에 가상 테이블 이라고 한다.
  3. 자주 사용하는 복잡한 쿼리문을 뷰로 저장해 두면 편리하게 사용 할 수 있다.
*/

# 뷰 생성
create view v_company as
select emp_id, e.dept_id, emp_name, position, gender, hire_date, salary, dept_name, location
from tbl_department d
inner join tbl_employee e
on d.dept_id = e.dept_id;

# 뷰 조회하기
select *
from v_company;
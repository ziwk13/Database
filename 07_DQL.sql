/*
DQL

1. 기본 구조
  SELECT 칼럼1, 칼럼2,... 칼럼N
  FROM 테이블
  WHERE 조건칼럼 = 값
  GROUP BY 그룹화칼럼1, 그룹화칼럼2, ... 그룹화칼럼N
  HAVING 그룹조건칼럼 = 값
  ORDER BY 정렬칼럼1 (ASC|DESC), 정렬칼럼2 (ASC|DESC), ...
  LIMIT 시작, 개수;
  
  2. 각 절의 실행 순서
    1) FROM 절
    데이터를 조회 할 테이블을 선택 한다.
    2) WHERE 절
    FROM 절에서 가져온 데이터 중 조건에 맞는 행만 선택
    3) GROUP BY
    WHERE 절을 통과한 데이터를 지정한 칼럼 기준으로 그룹화 한다
    4) HAVING 절
    GROUP BY 절에 의해서 그룹화된 결과 중에서 조건에 맞는 행만 선택 한다.
    5) SELECT 절
    지금 까지 과정을 거친 행(데이터)을 조회 할 때 조회할 칼럼을 작성 한다.
    6) ORDER BY 절
    SELECT 절에서 선택한 결과 집합을 지정한 칼럼 기준으로 정렬 한다.
    7) LIMIT 절
    지금까지 과정을 거친 행(데이터)을 조회 할 때 개수나 범위를 제한 한다.
    
    3. 기타 특징
    1) SELECT 절을 제외하면 모두 생략 할 수 있다.
    2) SELECT 절에서 조회할 칼럼에 별칭(ALIAS)을 부여 할 수 있는데, 이 별칭은 ORDER BY 절에서 사용 할 수 있다.
    (다른 절에서는 조회 할 칼럼에 지정한 별칭을 사용 할 수 없다.)
    3) GROUP BY 절 없이도 HAVING 절을 사용 할 수 있다.
    (전체 데이터를 하나의 그룹으로 간주하고 처리 한다.)
    4) ORDER BY 절에서 사용하는 정렬 키워드는 다음 의미를 가진다.
    (1) ASC : 오름차순 정렬, 생략 가능
    (2) DESC: 내림차순 정렬, 생략 불가능
    5) LIMIT 절의 시작 값은 생략 할 수 있다. 이 경우 데이터의 처음 부터 가져온다. ( 첫 행의 시작 값은 0 이다.)
    
*/

    create database if not exists db_company;
    # db_Company
    use db;
    
    # 1. 테이블 없이 데이터 조회하기 (표현식: 연산이나 함수 등)
   SELECT NOW();
   SELECT 1 + 1;
   
   # 2. 테이블 조회하기 (부서 테이블 활용)
   # 2-1 부서 테이블의 모든 데이터 조회하기
   SELECT 
    *
FROM
    tbl_department;  -- * : 모든 칼럼을 의미 한다. 실무에서는 사용을 금한다.
  
  # 2-2 부서명과 위치만 조회하기
  SELECT 
    dept_name, location
FROM
    tbl_department;
  
  # 2-3 부서명과 위치만 조회 하되, "부서명", "위치" 라는 칼럼 별칭 사용하기
  select dept_name as 부서명,
         location as "위치"  -- 별칭에 공백이 포함되면 반드시 "" 필요
  from tbl_department;
  
  # 2-4 부서명과 위치만 조회 하되, 테이블 별칭 사용 하기
  select d.dept_name as 부서명,
         d.location as 위치
  from tbl_department d;  -- 테이블의 경우 일반적으로 as 생략
  
  # 2-5 부서 위치만 조회 하되, 중복 제거 후 조회 하기
  SELECT DISTINCT
    location
FROM
    tbl_department;
    
  # 2-6 위치가 "대구"인 부서 조회하기
  SELECT 
    *
FROM
    tbl_department
WHERE
    location = '대구';  -- 비교 연산자: =, !=, >, >=, <, <=
    
    # 2-7 위치가 "대구"이고, 부서 아이디가 3 이상인 부서 조회 하기
    SELECT 
    *
FROM
    tbl_department
WHERE
    location = '대구' AND dept_id >= 3;  -- 논리 연산자: and, or
    
    # 2-8 위치가 "서울" 또는 "대구"인 부서 조회 하기
    SELECT 
    *
FROM
    tbl_department
WHERE
    location = '서울' OR location = '대구';  -- or 연산의 대체 연산:in()
    
    SELECT 
    *
FROM
    tbl_department
WHERE
    location IN ('서울' , '대구');  -- or 연산의 대체 연산:in()
    
    # 2-9 위치가 "서울" 또는 "대구"가 아닌 부서 조회 하기
    select * from tbl_department where location != '서울' and location <> '대구';  -- != 연산과 <> 연산은 같다
    
    select * from tbl_department where location not in('서울','대구');
    
    # 2-10 부서 아이디가 1 ~ 3인 부서 조회 하기
    select * from tbl_department where dept_id >= 1 and dept_id <= 3;
    
    select * from tbl_deprtment where dept_id between 1 and 3;  -- 1이상 3이하 (1과 3을 포함)
    
    # 2-11 부서 위치가 null 인 부서 조회 하기
    select * from tbl_department where location is null;
    
    # 2-12 부서 이름이 "영"으로 시작 하는 부서 조회 하기
     select * from tbl_department where dpt_name like "영%";  -- % : 와일드카드(만능문자), 글자 수 제한 없음
                                                              -- like" 와일드카드 전용 연산자, 와일드카드 사용 시 반드시 필요
                                                              -- "영%": 영으로 시작, "%did:영으로 긑, "%영%:  영을 포함 
                                                              
    # 2-13 부서의 위치별로 그룹화 하여 부서 수 조회하기
    # SUM(): 합계, AVG(): 평균, MAX(): 최대, MIN(): 최소, COUNT(): 개수
    select location from tbl_department group by location;
    
    select dept_name, location from tbl_department group by location;  -- group by 절의 칼럼만 조회 가능 (dept_name 칼럼 때문에 조회 실패)
    
    select location, count(*) from tbl_department group by location; -- count(*) :어떤 칼럼이든 값을 가지고 있으면 카운트에 포함
    
    # 2-14 부서의 위치별로 그룹화 하여 부서 수 조회 핟뢰, 부서 수가 2개 이상인 부서만 조회 하기
    select location as 부서위치, count(*) as 부서수 from tbl_department group by location having 부서수 >= 2;
    
    # 2-15 부서 이름 순으로 조회 하기
    select * from tbl_department order by dept_name asc; -- asc: 오름차순(가나다 순), 생략 가능
    
    select * from tbl_department order by dept_name desc;  -- desc: 내림차순
    
    # 2-16 부서 위치 순으로 조회 하되, 같은 위치의 부서들은 부서 이름 순으로 조회 하기
    select * from tbl_department order by location asc, dept_name asc;
    
    # 2-17 첫 번째 부서 부터 2개 부서만 조회 하기
    select * from tbl_department limit 0, 2;  -- 0: 첫 번째 부서를 의미함, 2: 2개 부서를 의미함
    
    # 2-18 세 번째 부서 부터 2개 부서만 조회하기
    select * from tbl_department limit 2, 2; -- 2: 세 번재 부서를 의미함 2: 2개 부서를 의미함
    
    # 2-19 부서 이름 순으로 조회 한 뒤 첫 2개 부서만 조회 하기
    select * from tbl_department order by dept_name asc limit 0, 2;
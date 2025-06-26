# 문제1. 게시글(Post)에 댓글(Comment) 달기
# 한 게시글에 여러 댓글이 달릴 수 있다.
# 게시글 제목, 게시글 내용, 게시글 작성일, 댓글 내용, 댓글 작성일 정보를 저장 한다

# 게시글 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_post (
    post_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    content TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)  ENGINE=INNODB;

#댓글 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_comment (
    comment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id)
        REFERENCES tbl_post (post_id)
        ON DELETE CASCADE
)  ENGINE=INNODB;

# 댓글 테이블 삭제
drop table if exists tbl_comment;

# 게시글 테이블 삭제
drop table if exists tbl_post;

# 문제2. 부서(Department)에 속한 직원(Emplogyee)
# 한 부서에 여러 직원이 속할 수 있다.
# 부서명, 부서위치, 부서장, 직원명, 입사일 정보를 저장 한다.

# 부서 테이블 생성 (외래키 없이 생성)
CREATE TABLE IF NOT EXISTS tbl_department (
    dept_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    dept_location VARCHAR(100) NULL,
    manager_id INT NULL
)  ENGINE=INNODB;

# 직원 테이블 생성 
CREATE TABLE IF NOT EXISTS tbl_employee (
    emp_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    dept_id int null,
    hired_at DATE NOT NULL
)  ENGINE=INNODB;

# 직원 테이블에 dept_id 칼럼 추가 하고 외래키 설정
alter table tbl_employee add column dept_id int null;
alter table tbl_employee add constraint fk_employee_department
FOREIGN KEY (dept_id) REFERENCES tbl_department (dept_id) on delete set null;

# 부서 테이블의 manager_id 칼럼 외래키 제약조건 추가
alter table tbl_department add constraint fk_department_manager
FOREIGN KEY (manager_id) REFERENCES tbl_employee (emp_id) on delete set null;

### 위와 같이 작업 하면 테이블 생성 순서에 문제가 발생하여 작업을 수행 할 수 없다.
### 실제로는 외래키 제약조건을 나중에 추가 한다.

--     FOREIGN KEY (manager_id)
--         REFERENCES tbl_employee (emp_id)  # 직원 테이블이 있어야만 부서 테이블을 만들 수 있다.
--         on delete set null                # 부서장이 삭제되면 manager_id를 null 처리 한다.
--         
--             FOREIGN KEY (dept_id)
--         REFERENCES tbl_department (dept_id)  # 부서 테이블이 있어야만 사원 테이블을 만들 수 있다.
--         on delete set null # 부서가 없어지면 dept_id를 null 처리 한다.

### 부서와 직원 테이블은 서로를 참조하는 순환 참조 구조를 가지기 때문에 DROP TABLE 만으로 
### 외래키 제약조건을 먼저 삭제한 다음 테이블을 삭제 할 수 있다.
alter table tbl_employee drop foreign key fk_employee_department;
alter table tbl_department drop foreign key fk_department_manager;
        
# 부서 테이블, 직원 테이블 삭제
drop table if exists tbl_employee, tbl_department;

# 데이터베이스 삭제
/*
 사용자 관련 쿼리문(SQL)
 
  1. 사용자 생성
    CREATE USER 사용자@호스트 IDENTIFIED BY 비밀번호;
    * 호스트 관련
      1) localhost: 로컬에서만 접근하는 사용자
      2) %        : 원격 접속이 가능한 사용자
      3) 특정IP v : 해당 IP에서만 접근하는 사용자
  2. 사용자 제거
    DROP USER 사용자@호스트
    * @호스트 생략 가능
  3. 사용자에게 권한 부여
    GRANT 권한 종류 PRIVILEGES ON 스키마.객체 TO 사용자@호스트
*/
/*
  데이터베이스(스키마) 관련 쿼리문
  
  1. 데이터베이스 생성
  CREATE DATABASE [IF NOT EXISTS] 데이터베이스;
  2. 데이터베이스 삭제
  DROP DATABASE [IF EXISTS] 데이터베이스;
*/

# 1. db_test 데이터베이스 만들기
CREATE DATABASE IF NOT EXISTS db_test;
SHOW DATABASES;

# 2. user_test 사용자 만들기
CREATE USER 'user_test'@'%' IDENTIFIED BY 'P@ssw0rd';
SELECT * FROM mysql.user;
#3. user_test 사용자에게 권한 부여하기
GRANT ALL PRIVILEGES ON db_test.* TO 'user_test'@'%'; # db_test 내부의 모든 것을 사용 할 수 있는 권한이 생성 된다.
SHOW GRANTS FOR 'user_test'@'%';
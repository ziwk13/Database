# 고객(Customer), 상품(Product), 구매(Purchase), 구매상세(PurchaseDetail), 테이블을 생성 하기
# 한 고객은 여러 번 구매 할 수 있다( 고객 - 구매 - 제품)
# 여러 번의 구매에는 각각 여러 제품이 포함 될 수 있다. ( 구매 - 구매상세 - 제품 )
# 고객 아이디, 고객명, 고객연락처, 제품아이디, 제품명, 제품가격, 재고, 구매아이디, 구매일, 구매한제품갯수

# 데이터베이스 생성
create database if not exists db_model;

# 데이터베이스 사용
use db_model;

# 고객 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_customer (
    customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_phone CHAR(11) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)  ENGINE=INNODB;

# 구매 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_purchase (
    purchase_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NULL,
    purchase_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    foreign key(customer_id) references tbl_customer(customer_id) on delete set null
)  ENGINE=INNODB;

# 제품 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_product (
    product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10 , 2 ) NOT NULL,
    discount DECIMAL(10 , 2 ) NOT NULL,
    stock INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)  ENGINE=INNODB;


# 구매 상세 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_purchase_detail (
    purchase_detail_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    purchase_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    FOREIGN KEY (purchase_id)
        REFERENCES tbl_purchase (purchase_id),
    FOREIGN KEY (product_id)
        REFERENCES tbl_product (product_id)
)  ENGINE=INNODB;
-- 윈도우 함수(누적 집계)

-- 문제: 일자 별 누적금액 구하기

-- 1. 테이블 생성 및 데이터 삽입
CREATE TABLE purchase (
    id INT(30),
    date DATE,
    price INT(30)
);

INSERT INTO purchase(id, date, price) VALUES (1, '2023-05-01', 100);
INSERT INTO purchase(id, date, price) VALUES (1, '2023-05-02', 200);
INSERT INTO purchase(id, date, price) VALUES (1, '2023-05-03', 300);
INSERT INTO purchase(id, date, price) VALUES (1, '2023-05-04', 400);
INSERT INTO purchase(id, date, price) VALUES (1, '2023-05-05', 500);
INSERT INTO purchase(id, date, price) VALUES (2, '2023-05-06', 600);
INSERT INTO purchase(id, date, price) VALUES (2, '2023-05-07', 700);

-- 2.1 쿼리(1)
SELECT
    id,
    date,
    price,
    SUM(price) OVER(PARTITION BY id ORDER BY date ASC) AS price2
FROM purchase
ORDER BY id, date ASC;

-- 2.2 쿼리(2)
SELECT
    id,
    date,
    price,
    SUM(price) OVER(PARTITION BY id ORDER BY date ASC) AS price2,
    SUM(price) OVER(PARTITION BY id ORDER BY date ASC ROWS 1 PRECEDING) AS price3,
    SUM(price) OVER(PARTITION BY id ORDER BY date ASC ROWS 2 PRECEDING) AS price4,
    SUM(price) OVER(PARTITION BY id ORDER BY date ASC ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS price5,
    SUM(price) OVER(PARTITION BY id ORDER BY date ASC ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS prirce6
FROM purchase
ORDER BY id, date ASC;
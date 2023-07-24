-- ROLLUP (개별 집계 + 총 집계)

-- 문제 : id 별 합계를 구하시오.

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
INSERT INTO purchase(id, date, price) VALUES (2, '2023-05-01', 100);
INSERT INTO purchase(id, date, price) VALUES (2, '2023-05-02', 200);

-- 2. 쿼리
SELECT
  id,
  SUM(price) AS total_price
FROM purchase
GROUP BY id WITH ROLLUP
ORDER BY id ASC;
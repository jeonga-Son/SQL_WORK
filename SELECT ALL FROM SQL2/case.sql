-- CASE를 활용한 조건별 집계

-- 문제 : 구매 조건에 따른 유저들의 거래금액

-- 1. 테이블 생성 및 데이터 삽입
CREATE TABLE purchase (
    id INT(30),
    price INT(30),
    type VARCHAR(10)
);

INSERT INTO purchase(id, price, type) VALUES (1, 100, 'a');
INSERT INTO purchase(id, price, type) VALUES (1, 100, 'b');
INSERT INTO purchase(id, price, type) VALUES (1, 100, 'b');
INSERT INTO purchase(id, price, type) VALUES (2, 100, 'a');
INSERT INTO purchase(id, price, type) VALUES (2, 100, 'a');
INSERT INTO purchase(id, price, type) VALUES (2, 100, 'b');

-- 2. CASE 사용 X
WITH a AS (
    SELECT
        id,
        SUM(price) AS total_price
    FROM purchase
    GROUP by 1
),
b AS (
    SELECT
        id,
        SUM(price) AS total_price
    FROM purchase
    WHERE type = 'a'
    GROUP by 1
),
c AS (
    SELECT
        id,
        SUM(price) AS total_price
    FROM purchase
    WHERE type = 'b'
    GROUP BY 1
)
SELECT
    a.id,
    a.total_price,
    b.total_price AS a_total_price,
    c.total_price AS b_totalPrice
FROM a
LEFT JOIN b
ON b.id = a.id
LEFT JOIN c
on c.id = a.id
ORDER BY a.id ASC;

-- 3. CASE 사용 O
SELECT
    id,
    SUM(price) AS total_price,
    SUM(CASE WHEN type = 'a' THEN price END) AS a_total_price,
    SUM(CASE WHEN type = 'b' THEN price END) AS b_total_price
FROM purchase
GROUP BY id
ORDER BY id ASC;
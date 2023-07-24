-- 윈도우 함수(이전 / 이후의 값 가져오기)

-- FIRST_VALUE(가져올 값) : 첫 번째 값 가져오기
-- LAST_VALUE(가져올 값) : 마지막 값 가져오기
-- LEAD(가져올 값, n) : n 번째 뒤에 있는 값 가져오기
-- LAG(가져올 값, n) : n 번째 앞에 있는 값 가져오기

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

-- 2. 쿼리 1
SELECT
    id,
    date,
    FIRST_VALUE(date) OVER(PARTITION BY id ORDER BY date ASC) AS first_value1,
    LAST_VALUE(date) OVER(PARTITION BY id ORDER BY date ASC) AS last_value1,
    LAST_VALUE(date) OVER(PARTITION BY id ORDER BY date ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_value2,
    LEAD(date, 1) OVER(PARTITION BY id ORDER BY date ASC) AS lead1,
    LAG(date, 1) OVER(PARTITION BY id ORDER BY date ASC) AS lag1
FROM purchase
ORDER BY id, date ASC;

-- 3. 쿼리 2
WITH a AS (
    SELECT
        id,
        date,
        LAG(date, 1) OVER(PARTITION BY id ORDER BY date ASC) AS lag1
    FROM purchase
)
SELECT
    id,
    date,
    lag1,
    DATEDIFF(date, lag1) AS diff_date
FROM a
ORDER BY id, date ASC;
-- WITH를 활용한 데이터 정리
-- WITH로 서브쿼리 대체하기

-- 문제 : 유저별 거래금액 추출

-- 1. 테이블 생성 및 데이터 삽입
CREATE TABLE member (
    id INT(30) PRIMARY KEY,
    name VARCHAR(30)
);

INSERT INTO member (id, name) VALUES(1, 'a');
INSERT INTO member (id, name) VALUES(2, 'b');
INSERT INTO member (id, name) VALUES(3, 'c');


CREATE TABLE purchase (
    id INT(30),
    price INT(30)
);

INSERT INTO purchase(id, price) VALUES(1, 100);
INSERT INTO purchase(id, price) VALUES(1, 200);
INSERT INTO purchase(id, price) VALUES(3, 300);

-- 2-1. 서브쿼리 사용
SELECT
    m.id,
    m.name,
    IFNULL(p.total_price, 0) AS total_price
FROM member AS m
LEFT JOIN (
    SELECT
        id,
        SUM(price) AS total_price
    FROM purchase
    GROUP BY 1
) AS p
ON p.id = m.id
ORDER BY m.id ASC;

-- 2-2. WITH 사용
WITH p AS (
    SELECT
        id,
        SUM(price) AS total_price
    FROM purchase
    GROUP BY 1
)
SELECT
    m.id,
    m.name,
    IFNULL(p.total_price, 0) AS total_price
FROM member AS m
LEFT JOIN p
ON p.id = m.id
ORDER BY m.id ASC;

-- 3. WITH 사용
-- 문제 : 전체 거래금액 대비 거래금액의 비중 추가
WITH p AS (
    SELECT
        id,
        SUM(price) AS total_price
    FROM purchase
    GROUP BY 1
),
member_purchase AS (
    SELECT
        m.id,
        m.name,
        IFNULL(p.total_price, 0) AS total_price
    FROM member AS m
    LEFT JOIN p
    ON p.id = m.id
),
final AS (
    SELECT
        id,
        name,
        total_price,
        total_price / (SELECT SUM(price) FROM purchase) * 100 AS percent
    FROM member_purchase
    ORDER BY id ASC
)
SELECT * FROM final;
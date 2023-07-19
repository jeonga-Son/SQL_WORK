-- UNION / UNION ALL
-- UNION : 중복값 제거
-- UNION ALL : 중복값 허용

-- 1. 테이블 생성 및 데이터 삽입
CREATE TABLE purchase (
    id INT(30),
    price INT(30),
    type VARCHAR(10)
);

INSERT INTO purchase(id, price, type) VALUES(1, 100, 'a');
INSERT INTO purchase(id, price, type) VALUES(1, 100, 'a');
INSERT INTO purchase(id, price, type) VALUES(1, 100, 'b');
INSERT INTO purchase(id, price, type) VALUES(1, 100, 'b');
INSERT INTO purchase(id, price, type) VALUES(2, 100, 'a');
INSERT INTO purchase(id, price, type) VALUES(2, 100, 'a');
INSERT INTO purchase(id, price, type) VALUES(2, 100, 'b');

-- 2. UNION ALL
SELECT -- // type = a 일 때의 id 별 거래금액 합계
  id,
  SUM(price) AS total_price
FROM purchase
WHERE type = 'a'
GROUP BY id
UNION ALL
SELECT -- // type = b 일 때의 id 별 거래금액 합계
  id,
  SUM(price) AS total_price
FROM purchase
where type = 'b'
GROUP BY id;

-- 3. UNION
SELECT
  id,
  SUM(price) AS total_price
FROM purchase
WHERE type = 'a'
GROUP BY id
UNION
SELECT
  id,
  SUM(price) AS total_price
FROM purchase
where type = 'b'
GROUP BY id;
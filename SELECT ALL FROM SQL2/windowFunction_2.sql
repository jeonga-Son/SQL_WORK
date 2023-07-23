-- 윈도우 함수(순위 정하기)

-- ROW_NUMBER : 순서대로 1씩 증가
-- RANK : 값이 동일한 경우 동일한 순위를 부여하고 다음 순위에서 떨어진 순위로 출력
-- DENSE_RANK : 값이 동일할 경우 동일한 순위를 부여하고 다음 순위에 +1 순위로 출력

-- 문제 : id 별 date 순대로 순위 부여하기

-- 1. 테이블 생성 및 데이터 삽입
CREATE TABLE purchase (
    id INT(30),
    date DATE,
    price INT(30)
);

INSERT INTO purchase(id, date, price) VALUES (1, '2023-05-01', 100);
INSERT INTO purchase(id, date, price) VALUES (1, '2023-05-02', 200);
INSERT INTO purchase(id, date, price) VALUES (1, '2023-05-02', 300);
INSERT INTO purchase(id, date, price) VALUES (1, '2023-05-03', 300);
INSERT INTO purchase(id, date, price) VALUES (1, '2023-05-04', 400);
INSERT INTO purchase(id, date, price) VALUES (1, '2023-05-05', 500);
INSERT INTO purchase(id, date, price) VALUES (2, '2023-05-01', 100);
INSERT INTO purchase(id, date, price) VALUES (2, '2023-05-02', 200);

-- 2. 쿼리
SELECT
  id,
  date,
  price,
  ROW_NUMBER() OVER(PARTITION BY id ORDER BY date ASC) AS func_row_number,
  RANK() OVER(PARTITION BY id ORDER BY date ASC) AS func_rank,
  DENSE_RANK() OVER(PARTITION BY id ORDER BY date ASC) AS func_dense_rank
FROM purchase
ORDER BY id, date, price ASC;
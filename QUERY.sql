
-- 1. Number 
SELECT
  match_id,
  fixture,
  base_ticket_price
FROM
  matches
WHERE
  match_status = 'Available'
  AND tournament_category = 'Champions League'



  -- 2. Number
SELECT
  user_id,
  full_name,
  email
FROM
  users
WHERE
  full_name ILIKE 'Tanvir%'
  OR full_name ILIKE '%Haque%'


  
  -- 3. Number
SELECT
  booking_id,
  user_id,
  match_id,
  coalesce(payment_status, 'Action Required') AS systematic_status
FROM
  bookings
WHERE
  payment_status IS NULL;


-- 4. Number
SELECT
  b.booking_id,
  u.full_name,
  m.fixture,
  b.total_cost
FROM
  bookings AS b
  INNER JOIN users AS u ON b.user_id = u.user_id
  INNER JOIN matches AS m ON b.match_id = m.match_id;


-- 5. Number
SELECT
  u.user_id,
  u.full_name,
  b.booking_id
FROM
  users AS u
  LEFT JOIN bookings AS b ON u.user_id = b.user_id;


-- 6. Number
SELECT
  booking_id,
  match_id,
  total_cost
FROM
  bookings
WHERE
  total_cost > (
    SELECT
      avg(total_cost)
    FROM
      bookings
  );


-- 7. Number
SELECT
  match_id,
  fixture,
  base_ticket_price
FROM
  matches
ORDER BY
  base_ticket_price DESC
OFFSET
  1
LIMIT
  2;
CREATE TABLE Users (
  user_id serial PRIMARY KEY,
  full_name varchar(100) NOT NULL,
  email varchar(100) UNIQUE NOT NULL,
  role varchar(50) NOT NULL CHECK (role IN ('Football Fan', 'Ticket Manager')),
  phone_number varchar(20)
);


CREATE TABLE Matches (
  match_id serial PRIMARY KEY,
  fixture varchar(150) NOT NULL,
  tournament_category varchar(20) NOT NULL,
  base_ticket_price int NOT NULL CHECK (base_ticket_price >= 0),
  match_status varchar(50) NOT NULL CHECK (
    match_status IN (
      'Available',
      'Selling Fast',
      'Sold Out',
      'Postponed'
    )
  )
);


CREATE TABLE Bookings (
  booking_id serial PRIMARY KEY,
  user_id int NOT NULL,
  match_id int NOT NULL,
  seat_number varchar(20),
  payment_status varchar(30) CHECK (
    payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
  ),
  total_cost int NOT NULL CHECK (total_cost >= 0),
  FOREIGN KEY (user_id) REFERENCES Users (user_id),
  FOREIGN KEY (match_id) REFERENCES Matches (match_id)
);


INSERT INTO
  Users (user_id, full_name, email, role, phone_number)
VALUES
  (
    1,
    'Tanvir Rahman',
    'tanvir@mail.com',
    'Football Fan',
    '+8801711111111'
  ),
  (
    2,
    'Asif Haque',
    'asif@mail.com',
    'Football Fan',
    '+8801722222222'
  ),
  (
    3,
    'Sajjad Rahman',
    'sajjad@mail.com',
    'Ticket Manager',
    '+8801733333333'
  ),
  (
    4,
    'Jannat Ara',
    'jannat@mail.com',
    'Football Fan',
    NULL
  );


INSERT INTO
  Matches (
    match_id,
    fixture,
    tournament_category,
    base_ticket_price,
    match_status
  )
VALUES
  (
    101,
    'Real Madrid vs Barcelona',
    'Champions League',
    150.00,
    'Available'
  ),
  (
    102,
    'Man City vs Liverpool',
    'Premier League',
    120.00,
    'Selling Fast'
  ),
  (
    103,
    'Bayern Munich vs PSG',
    'Champions League',
    130.00,
    'Available'
  ),
  (
    104,
    'AC Milan vs Inter Milan',
    'Serie A',
    90.00,
    'Sold Out'
  ),
  (
    105,
    'Juventus vs Roma',
    'Serie A',
    80.00,
    'Available'
  );


INSERT INTO
  Bookings (
    booking_id,
    user_id,
    match_id,
    seat_number,
    payment_status,
    total_cost
  )
VALUES
  (501, 1, 101, 'A-12', 'Confirmed', 150.00),
  (502, 1, 102, 'B-04', 'Confirmed', 120.00),
  (503, 2, 101, 'A-13', 'Confirmed', 150.00),
  (504, 2, 101, NULL, NULL, 150.00),
  (505, 3, 102, 'C-20', 'Pending', 120.00);


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
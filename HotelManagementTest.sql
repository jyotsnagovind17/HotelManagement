Show tables;
describe users;
describe hotels;
describe rooms;
describe bookings;
-- insert data into users table
INSERT INTO users (username, password, role)
VALUES
('admin_user', 'admin123', 'admin'),
('jyokar', 'password123', 'customer');
select * from users;
-- insert data into  hotels table
INSERT INTO hotels (hotel_id, hotelname, location, rating)
VALUES
(1, 'Hotel Sunshine', 'Bangalore, India', 4.5),
(2, 'Ocean View Resort', 'Goa, India', 4.7),
(3, 'Mountain Retreat', 'Bangalore, India', 4.3);
select * from hotels;
INSERT INTO hotels (hotel_id, hotelname, location, rating)
VALUES
(4, 'Palm Springs', 'Goa, India', 4.6),
(5, 'Country Inn', 'Bangalore, India', 4.2);
select * from hotels;
-- insert data to rooms table
INSERT INTO rooms (hotel_id, room_type, price_per_night, is_occupied)
VALUES
(1, 'suite', 5000.00, FALSE),
(1, 'double', 3500.00, TRUE),
(2, 'single', 2500.00, FALSE),
(2, 'suite', 6000.00, TRUE),
(3, 'double', 3000.00, FALSE);
select * from rooms;
SELECT hotel_id, room_id, room_type, price_per_night, is_occupied
FROM rooms;
INSERT INTO rooms (hotel_id, room_type, price_per_night, is_occupied)
VALUES
(3, 'suite', 6000.00, FALSE),
(4, 'double', 2500.00, TRUE),
(4, 'single', 1500.00, FALSE),
(5, 'suite', 6000.00, TRUE),
(5, 'double', 3500.00, TRUE);
SELECT hotel_id, room_id, room_type, price_per_night, is_occupied
FROM rooms;
select * from users;
delete from users where user_id not in (1,2);
select * from rooms where is_occupied = 'FALSE';
select * from bookings where user_id = (select user_id from users where username = 'jyokar');
select sum(total_price) as Total_revenue from bookings;
select * from bookings where check_in_date >= '2024-12-17' and check_out_date <= '2024-12-25';
alter table bookings 
add constraint check_dates check( check_in_date < check_out_date);
alter table rooms
add constraint positive_price check (price_per_night > 0);
Truncate table bookings;
update rooms set is_occupied = false;
show triggers from HotelManagement;
select * from bookings;
INSERT INTO bookings (user_id, room_id, check_in_date, check_out_date, total_price)
Values
( 2, 1, '2024-12-15', '2024-12-17', 5000 ),
( 2, 3, '2024-12-17', '2024-12-24', 2500 );
select * from rooms;
delete from bookings where booking_id = 1;


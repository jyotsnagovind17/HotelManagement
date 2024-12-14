Create DATABASE HotelManagement;
USE HotelManagement;
Create TABLE users (
user_id int auto_increment primary key,
username varchar(50) not null,
password varchar(100) not null,
role ENUM ('admin','customer') not null );
Create TABLE hotels (
hotel_id int auto_increment primary key,
hotelname varchar(100) not null,
location varchar(100) not null,
rating decimal(2,1) default 0.0 );
Create TABLE rooms (
room_id int auto_increment primary key,
hotel_id int not null,
room_type ENUM ('single', 'double', 'suite') not null,
price_per_night decimal (10,2) not null,
is_occupied boolean default false,
foreign key (hotel_id) references hotels(hotel_id));
Create TABLE bookings (
booking_id int auto_increment primary key,
user_id int not null,
room_id int not null,
check_in_date date not null,
check_out_date date not null,
total_price decimal (10,2) not null,
foreign key (user_id) references users(user_id),
foreign key (room_id) references rooms(room_id));

DROP TRIGGER IF EXISTS prevent_double_booking;
DELIMITER $$
create trigger prevent_double_booking
before insert on bookings 
for each row begin
if exists ( select 1 from bookings where room_id= NEW.room_id
and NEW.check_in_date < check_out_date and NEW.check_out_date > check_in_date)
then signal sqlstate '45000'
set message_text = 'Double booking is not allowed for the same room!';
end if;
END $$

DROP TRIGGER IF EXISTS after_booking_insert;
DELIMITER $$
create trigger after_booking_insert
after insert on bookings
for each row begin 
update rooms set is_occupied = TRUE where room_id= NEW.room_id;
END $$

DROP trigger if exists after_booking_delete;
-- bookings table after a booking is canceled or deleted
DELIMITER $$
create trigger after_booking_delete
after delete on bookings
for each row begin
update rooms set is_occupied = false where room_id= OLD.room_id;
END $$


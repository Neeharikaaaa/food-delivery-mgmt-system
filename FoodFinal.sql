drop table operating_hours;
drop table order_details;
drop table orders;
drop table payment;
drop table delivery_person;
drop table bill_temp;
drop table item;
drop table restaurant;
drop table customer;
drop table location;

create table location (
    pincode number(6) CONSTRAINT pin_pk primary key,
    city varchar2(20) CONSTRAINT city_nn not null
);

create table customer (
    cid number(5) CONSTRAINT cid_pk primary key,
    pw varchar2(10) CONSTRAINT cust_pw_nn not null,
    cname varchar2(30) CONSTRAINT cname_nn not null,
    dob date CONSTRAINT date_nn not null,
    phone number(10) CONSTRAINT ph_unq_nn unique not null,
    door varchar2(7) CONSTRAINT door_nn not null,
    street varchar2(25) CONSTRAINT street_nn not null,
    area varchar2(25) CONSTRAINT area_nn null,
    pincode number(6) CONSTRAINT pin_nn_fk references location(pincode),
    memtype varchar2(10),
    pts number(6),
    constraint cust_check2 check (memtype in ('gold', 'silver'))
);

create table delivery_person (
    dpid number(5) CONSTRAINT dpid_pk primary key,
    pw varchar2(10) CONSTRAINT dp_pw_nn not null,
    dpname varchar2(30) CONSTRAINT dpname_nn not null,
    dob date CONSTRAINT dp_date_nn null,
    phone number(10) CONSTRAINT dp_ph_unq_nn unique not null,
    hiredate date CONSTRAINT hiredate_nn not null,
    salary number(8,2) CONSTRAINT sal_nn not null,
    pincode number(6) CONSTRAINT dp_pin_fk not null references location(pincode)
);

create table restaurant (
    rid number(5) ,
    bid number(5) ,
    rname varchar2(20) CONSTRAINT rname_nn not null,
    door varchar2(7) CONSTRAINT rest_door_nn not null,
    street varchar2(25) CONSTRAINT rest_street_nn not null,
    area varchar2(25) CONSTRAINT rest_area_nn not null,
    pincode number(6) CONSTRAINT rest_pin_fk not null references location(pincode),
    phone number(10) CONSTRAINT rphone_nn_unq not null unique,
    cuisine varchar2(20),
    rating number(2) check (rating between 1 and 5),
    constraint rest_pk primary key (rid, bid)
);

create table item (
    iid number(5) CONSTRAINT iid_pk primary key,
    iname varchar2(20) CONSTRAINT iname_nn not null,
    type varchar2(15) CONSTRAINT type_nn not null,
    subtype varchar2(15),
    veg varchar2(3) CONSTRAINT veg_nn not null,
    price number(5) CONSTRAINT price_nn not null, 
    rid number(5) not null,
    bid number(5) not null,
    constraint i_c2 check (veg in ('yes', 'no')),
    constraint i_c3 check (price > 0),
    constraint i_fk1 foreign key (rid, bid) references restaurant(rid, bid)
);

create table payment (
    payid number(5) CONSTRAINT payid_pk primary key,
    paytype varchar2(10) CONSTRAINT paytype_nn not null,
    status varchar2(10) CONSTRAINT status_nn not null,
    amt number(7) CONSTRAINT amt_nn not null,
    constraint pay_c2 check (paytype in ('Netbanking','Google Pay', 'Card', 'Cash')),
    constraint pay_c3 check (status in ('unpaid', 'paid'))
);

create table orders (
    oid number(5) CONSTRAINT oid_pk primary key,
    cid number(5) CONSTRAINT o_cid_fk references customer(cid),
    dpid number(5) CONSTRAINT o_dpid_fk  references delivery_person(dpid),
    rid number(5),
    bid number(5),
    odate date  CONSTRAINT o_date_nn not null,
    ddate date CONSTRAINT o_ddate_nn not null,
    rating number(2) check (rating between 1 and 5),
    review varchar2(100),
    pid number(5) CONSTRAINT o_pid_fk references payment(payid),
    constraint o_fk1 foreign key (rid, bid) references restaurant(rid, bid)
);

create table order_details (
    oid number(5) CONSTRAINT od_oid_fk references orders(oid),
    iid number(5) CONSTRAINT od_iid_fk references item(iid),
    qty number(3) CONSTRAINT od_qty_nn not null,
    constraint od_c1 check (qty > 0),
    constraint od_c2 primary key (oid, iid)
);

create table operating_hours (
    rid number(5),
    bid number(5),
    day_of_week varchar2(10) CONSTRAINT chk_dow check (day_of_week in ('weekday', 'weekend')),
    open_time interval day(0) to second(0), 
    close_time interval day(0) to second(0), 
    constraint oh_fk1 foreign key (rid, bid) references restaurant(rid, bid),
    constraint oh_c1 check (open_time<close_time),
    constraint oh_c2 primary key (rid, bid, day_of_week)
);

create table bill(
    name varchar(20),
    price number(8,2),
    qty number(3),
    total number(10));


-- Inserting sample data into tables

-- location
insert into location values (600001, 'Chennai');
insert into location values (600002, 'Chennai');
insert into location values (600003, 'Chennai');
insert into location values (560001, 'Bangalore');
insert into location values (560002, 'Bangalore');
insert into location values (560003, 'Bangalore');
insert into location values (400001, 'Mumbai');
insert into location values (400002, 'Mumbai');
insert into location values (400003, 'Mumbai');


-- customer
insert into customer values (1, 'pass1234', 'Rahul', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 9876543210, '1A', 'Lakshmi Nagar', 'Tambaram', 600001, 'gold', 1000);
insert into customer values (2, 'pass2345', 'Priya', TO_DATE('1985-09-20', 'YYYY-MM-DD'), 9876543211, '2B', 'Appaswamy', 'Anna Nagar', 600002, 'silver', 800);
insert into customer values (3, 'pass3456', 'Raj', TO_DATE('1992-12-10', 'YYYY-MM-DD'), 9876543212, '3C', 'Opaline', 'Nungambakkam', 600003, 'gold', 1200);
insert into customer values (4, 'pass4567', 'Aishwarya', TO_DATE('1988-04-25', 'YYYY-MM-DD'), 9876543213, '4D', 'Reddy Colony', 'Rajajinagar', 560001, 'silver', 900);
insert into customer values (5, 'pass5678', 'Suresh', TO_DATE('1995-08-08', 'YYYY-MM-DD'), 9876543214, '5E', 'Kumar Street', 'Indiranagar', 560002, 'gold', 1100);
insert into customer values (6, 'password6', 'Vijay Shah', TO_DATE('1991-07-20', 'YYYY-MM-DD'), 9876543215, '6F', 'Shah Lane', 'Andheri', 400001, 'gold', 1100);
insert into customer values (7, 'pass8', 'Nitin', TO_DATE('1994-03-05', 'YYYY-MM-DD'), 9876543217, '8H', 'Patel Road', 'Malad', 400003, 'gold', 1200);
insert into customer values (8, 'pass4', 'Aruna', TO_DATE('1992-04-22', 'YYYY-MM-DD'), 9876543204, '15', 'Anna Salai', 'T Nagar', 600001, 'gold', 200);
insert into customer values (9, 'pass5', 'Arjun', TO_DATE('1995-11-12', 'YYYY-MM-DD'), 9876543205, '10', 'Mount Road', 'Saidapet', 600003, 'silver', 100);
insert into customer values (10, 'pass6', 'Manoj', TO_DATE('1988-07-15', 'YYYY-MM-DD'), 9876543206, '7', 'Brigade Road', 'Brigade Layout', 560001, 'gold', 300);
insert into customer values (11, 'passw7','Ayesha', TO_DATE('1993-01-30', 'YYYY-MM-DD'), 9876543207, '12', 'Indiranagar 100 Feet Road', 'Indiranagar', 560002, 'silver', 150);
insert into customer values (12, 'passw8', 'Rahul', TO_DATE('1986-09-05', 'YYYY-MM-DD'), 9876543208, '25', 'Nariman Point', 'Fort', 400001, 'gold', 250);
insert into customer values (13, 'passw9', 'Jyoti', TO_DATE('1991-03-18', 'YYYY-MM-DD'), 9876543209, '20', 'Linking Road', 'Bandra', 400002, 'silver', 120);
insert into customer values (14, 'pass7', 'Pooja', TO_DATE('1987-11-12', 'YYYY-MM-DD'), 9876543216, '7G', 'Desai Colony', 'Bandra', 400002, 'silver', 900);

-- delivery_person
insert into delivery_person values (1, 'pass1', 'Suresh Kumar', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 9876543201, TO_DATE('2010-02-20', 'YYYY-MM-DD'), 25000, 600001);
insert into delivery_person values (2, 'pass2', 'Rajesh Singh', TO_DATE('1990-08-25', 'YYYY-MM-DD'), 9876543202, TO_DATE('2013-06-10', 'YYYY-MM-DD'), 27000, 600002);
insert into delivery_person values (3, 'pass3', 'Priya Raman', TO_DATE('1993-12-10', 'YYYY-MM-DD'), 9876543203, TO_DATE('2015-08-05', 'YYYY-MM-DD'), 23000, 600003);
insert into delivery_person values (4, 'pass4', 'Anand Kumar', TO_DATE('1987-03-20', 'YYYY-MM-DD'), 9876543204, TO_DATE('2011-05-12', 'YYYY-MM-DD'), 26000, 560001);
insert into delivery_person values (5, 'pass5', 'Divya Rao', TO_DATE('1992-09-05', 'YYYY-MM-DD'), 9876543205, TO_DATE('2014-10-18', 'YYYY-MM-DD'), 28000, 560002);
insert into delivery_person values (6, 'pass6', 'Ravi Shankar', TO_DATE('1989-06-15', 'YYYY-MM-DD'), 9876543206, TO_DATE('2012-08-20', 'YYYY-MM-DD'), 24000, 560003);
insert into delivery_person values (7, 'pass7', 'Kiran Patel', TO_DATE('1986-11-30', 'YYYY-MM-DD'), 9876543207, TO_DATE('2010-01-25', 'YYYY-MM-DD'), 27000, 400001);
insert into delivery_person values (8, 'password8', 'Anjali Desai', TO_DATE('1991-04-18', 'YYYY-MM-DD'), 9876543208, TO_DATE('2013-09-10', 'YYYY-MM-DD'), 29000, 400002);
insert into delivery_person values (9, 'password9', 'Prakash Shah', TO_DATE('1994-07-12', 'YYYY-MM-DD'), 9876543209, TO_DATE('2015-12-05', 'YYYY-MM-DD'), 25000, 400003);


-- restaurant

insert into restaurant values (1, 1, 'Sangeetha', '5', 'High Street', 'Market', 600001, 5678901234, 'Indian', 4);
insert into restaurant values (1, 2, 'Sangeetha', '6', 'Beach Road', 'Residential Area', 600003, 5678901233, 'Indian', 4);
insert into restaurant values (2, 1, 'Pizza Hut', '7', 'Broadway', 'City Center', 560001, 6789012345, 'Fast Food', 5);
insert into restaurant values (2, 2, 'Pizza Hut', '8', 'Main Street', 'Downtown', 600002, 6789012344, 'Fast Food', 5);
insert into restaurant values (3, 2, 'Wang''s Kitchen', '9', 'Park Avenue', 'Green Area', 400001, 7890123456, 'Chinese', 3);
insert into restaurant values (4, 1, 'Erode Amman Mess', '20', 'Boulevard', 'Sea Side', 600002, 8901234567, 'Indian', 4);
insert into restaurant values (5, 1, 'Delhi Highway', '25', 'Main Road', 'Industrial Area', 400002, 9012345678, 'Indian', 5);
insert into restaurant values (6, 1, 'Taco Bell', '1', 'Main Road', 'Industrial Area', 600001, 9012345677, 'Mexican', 5);


-- item
-- Sangeetha
insert into item values (1, 'Masala Dosa', 'Main Course', 'Dosa', 'yes', 60, 1, 1);
insert into item values (2, 'Ghee Roast Dosa', 'Main Course', 'Dosa', 'yes', 70, 1, 1);
insert into item values (3, 'Onion Uthappam', 'Main Course', 'Uthappam', 'yes', 80, 1, 1);

-- Pizza Hut
insert into item values (4, 'Margherita Pizza', 'Main Course', 'Cheese', 'yes', 200, 2, 1);
insert into item values (5, 'Pepperoni Pizza', 'Main Course', 'Non-veg', 'no', 250, 2, 1);
insert into item values (6, 'Farmhouse Pizza', 'Main Course', null, 'yes', 220, 2, 1);

-- Wang's Kitchen
insert into item values (7, 'Veg Fried Rice', 'Main Course', null, 'yes', 150, 3, 2);
insert into item values (8, 'Chicken Fried Rice', 'Main Course', null, 'no', 180, 3, 2);
insert into item values (9, 'Chilli Chicken', 'Starter', 'Spicy', 'no', 170, 3, 2);

-- Erode Amman Mess
insert into item values (10, 'Fish Curry', 'Main Course', 'Curry', 'yes', 180, 4, 1);
insert into item values (11, 'Chicken Biryani', 'Main Course', 'Biryani', 'no', 200, 4, 1);
insert into item values (12, 'Erode Special Meals', 'Main Course', null, 'yes', 150, 4, 1);

-- Delhi Highway
insert into item values (13, 'Butter Chicken', 'Main Course', 'Curry', 'no', 220, 5, 1);
insert into item values (14, 'Dal Makhani', 'Main Course', 'Dal', 'yes', 180, 5, 1);
insert into item values (15, 'Garlic Naan', 'Main Course', 'Bread', 'yes', 50, 5, 1);

-- Sangeetha
insert into item values (16, 'Masala Dosa', 'Main Course', 'Dosa', 'yes', 60, 1, 2);
insert into item values (17, 'Ghee Roast Dosa', 'Main Course', 'Dosa', 'yes', 70, 1, 2);
insert into item values (18, 'Onion Uthappam', 'Main Course', 'Uthappam', 'yes', 80, 1, 2);

-- Pizza Hut
insert into item values (19, 'Margherita Pizza', 'Main Course', 'Cheese', 'yes', 200, 2, 2);
insert into item values (20, 'Pepperoni Pizza', 'Main Course', 'Non-veg', 'no', 250, 2, 2);
insert into item values (21, 'Farmhouse Pizza', 'Main Course', null, 'yes', 220, 2, 2);

-- payment
insert into payment values (1, 'Google Pay', 'paid', 190);
insert into payment values (2, 'Cash', 'unpaid', 640);
insert into payment values (3, 'Card', 'paid', 330);
insert into payment values (4, 'Google Pay', 'unpaid', 580);
insert into payment values (5, 'Cash', 'paid', 580);

-- orders
insert into orders values (1, 1, 1, 1, 1, TO_DATE('2024-06-08', 'YYYY-MM-DD'), TO_DATE('2024-06-08', 'YYYY-MM-DD'), 4, 'Good food and prompt delivery', 1);
insert into orders values (2, 2, 2, 2, 1, TO_DATE('2024-06-08', 'YYYY-MM-DD'), TO_DATE('2024-06-08', 'YYYY-MM-DD'), 5, 'Excellent service and tasty pizza', 2);
insert into orders values (3, 3, 3, 3, 2, TO_DATE('2024-06-08', 'YYYY-MM-DD'), TO_DATE('2024-06-08', 'YYYY-MM-DD'), 3, 'Average food quality', 3);
insert into orders values (4, 4, 4, 4, 1, TO_DATE('2024-06-08', 'YYYY-MM-DD'), TO_DATE('2024-06-08', 'YYYY-MM-DD'), 4, 'Delicious Indian food', 4);
insert into orders values (5, 5, 5, 5, 1, TO_DATE('2024-06-08', 'YYYY-MM-DD'), TO_DATE('2024-06-08', 'YYYY-MM-DD'), 5, 'Best butter chicken ever!', 5);

-- order_details
insert into order_details values (1, 1, 2);
insert into order_details values (1, 2, 1);
insert into order_details values (2, 4, 1);
insert into order_details values (2, 6, 2);
insert into order_details values (3, 7, 1);
insert into order_details values (3, 8, 1);
insert into order_details values (4, 10, 1);
insert into order_details values (4, 11, 2);
insert into order_details values (5, 13, 1);
insert into order_details values (5, 14, 2);

-- operating_hours
insert into operating_hours values (1, 1, 'weekday', INTERVAL '09:00:00' HOUR TO SECOND, INTERVAL '21:00:00' HOUR TO SECOND);
insert into operating_hours values (1, 1, 'weekend', INTERVAL '09:00:00' HOUR TO SECOND, INTERVAL '22:00:00' HOUR TO SECOND);
insert into operating_hours values (1, 2, 'weekday', INTERVAL '10:00:00' HOUR TO SECOND, INTERVAL '20:00:00' HOUR TO SECOND);
insert into operating_hours values (1, 2, 'weekend', INTERVAL '10:00:00' HOUR TO SECOND, INTERVAL '21:00:00' HOUR TO SECOND);
insert into operating_hours values (2, 1, 'weekday', INTERVAL '11:00:00' HOUR TO SECOND, INTERVAL '22:00:00' HOUR TO SECOND);
insert into operating_hours values (2, 1, 'weekend', INTERVAL '11:00:00' HOUR TO SECOND, INTERVAL '23:00:00' HOUR TO SECOND);
insert into operating_hours values (2, 2, 'weekday', INTERVAL '10:30:00' HOUR TO SECOND, INTERVAL '21:30:00' HOUR TO SECOND);
insert into operating_hours values (2, 2, 'weekend', INTERVAL '10:30:00' HOUR TO SECOND, INTERVAL '22:30:00' HOUR TO SECOND);
insert into operating_hours values (3, 2, 'weekday', INTERVAL '11:30:00' HOUR TO SECOND, INTERVAL '22:30:00' HOUR TO SECOND);
insert into operating_hours values (3, 2, 'weekend', INTERVAL '11:30:00' HOUR TO SECOND, INTERVAL '23:00:00' HOUR TO SECOND);
insert into operating_hours values (4, 1, 'weekday', INTERVAL '12:00:00' HOUR TO SECOND, INTERVAL '22:00:00' HOUR TO SECOND);
insert into operating_hours values (4, 1, 'weekend', INTERVAL '12:00:00' HOUR TO SECOND, INTERVAL '22:30:00' HOUR TO SECOND);
insert into operating_hours values (5, 1, 'weekday', INTERVAL '12:30:00' HOUR TO SECOND, INTERVAL '21:30:00' HOUR TO SECOND);
insert into operating_hours values (5, 1, 'weekend', INTERVAL '12:30:00' HOUR TO SECOND, INTERVAL '22:00:00' HOUR TO SECOND);
insert into operating_hours values (6, 1, 'weekday', INTERVAL '10:00:00' HOUR TO SECOND, INTERVAL '22:00:00' HOUR TO SECOND);
insert into operating_hours values (6, 1, 'weekend', INTERVAL '10:00:00' HOUR TO SECOND, INTERVAL '23:00:00' HOUR TO SECOND);




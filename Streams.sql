 CREATE OR REPLACE TABLE members (
   id number(8) NOT NULL,
   name varchar(255) default NULL,
   fee number(3) NULL
 );

 CREATE OR REPLACE STREAM members_stream ON TABLE members;

 CREATE OR REPLACE TABLE signup (
   id number(8),
   dt DATE
   );
 INSERT INTO members (id,name,fee)
 VALUES
 (1,'Joe',0),
 (2,'Jane',0),
 (3,'George',0),
 (4,'Betty',0),
 (5,'Sally',0);

 INSERT INTO signup
 VALUES
 (1,'2018-01-01'),
 (2,'2018-02-15'),
 (3,'2018-05-01'),
 (4,'2018-07-16'),
 (5,'2018-08-21');

 select * from members_stream

 MERGE INTO members m
   USING (
     SELECT id, dt
     FROM signup s
     WHERE DATEDIFF(day, '2018-08-15'::date, s.dt::DATE) < -30) s
     ON m.id = s.id
   WHEN MATCHED THEN UPDATE SET m.fee = 90;

   select * from members

   select * from members_stream

 update members set fee = '95' where id = 2

 update members set name = 'praveen' where id = 3

 select * from members_stream


 create or replace table customer(
 id number,
 first_name varchar,
 last_name varchar,
 date_of_birth date,
 active_flag boolean,
 city varchar
 )
 insert into customer values
 (1, 'Joan', 'Luk', '3/15/2003', TRUE, 'New York'),
 (2, 'Patrick', 'Renard', '4/29/2003', FALSE, 'Los Angeles'),
 (3, 'Sim', 'Rose', '8/25/2008', TRUE, 'Chicago'), 
 (4, 'Lila', 'Vis', '9/19/1997', TRUE, 'Miami'),
 (5, 'Charlie', 'Cook', '3/19/2003', FALSE, 'Dallas'),
 (6, 'Ryan', 'Clark', '4/13/2003', TRUE, 'Philadelphia'),
 (7, 'Davis', 'Bashful', '2/15/2003', TRUE, 'Houston'), 
 (8, 'Nalty', 'Mason', '3/21/2003', TRUE, 'Atlanta'),
 (9, 'Quinn', 'Ris', '8/13/1997', TRUE, 'Washington'),
 (10, 'White', 'Klein', '1/21/2003', TRUE, 'Boston');

 select * from customer

 create or replace stream customer_stream on table customer

 select * from customer_stream

 insert into customer values
 (11, 'Irwin', 'Chuk', '8/13/2000', TRUE, 'San Jose'), (12, 'Daniel', 'Jiw', '1/21/2000', TRUE, 'Newark');


 select * from customer_stream

 delete from customer where id = 9

 update customer set city = 'New Jersey' where id = 3
 update customer set active_flag = TRUE where id = 5

 select * from customer
 select * from customer_stream

 show streams

 desc stream customer_stream

 create or replace stream customer_stream_02 on table customer

 insert into customer values
 (13, 'Irwin-01', 'Chuk', '8/13/2000', TRUE, 'San Jose'), (14, 'Daniel-01', 'Jiw', '1/21/2000', TRUE, 'Newark');


 select * from customer_stream_02









create or replace table cust_dim(
id number,
first_name varchar,
last_name varchar,
date_of_birth date,
active_flag boolean,
city varchar,
insert_time timestamp default current_timestamp()
)

create or replace sequence cust_seq
start 2
increment 2

create or replace task task_01
warehouse = PRAVEEN_WAREHOUSE
schedule = '1 minute'
as
insert into cust_dim
values(cust_seq.nextval,'Fname','Lname',current_date(),TRUE, 'MyCity',current_timestamp())

show tasks

alter task task_01 resume

desc task task_01

create task task_clone  clone task_01

show tasks
select * from table(information_schema.task_history()) where name ='TASK_01'

SQL compilation error: Insert value list does not match column list expecting 7 but got 6


CREATE OR REPLACE TABLE cust_tree(
id integer autoincrement,
level varchar,
fname varchar
)

create or replace task parent_task_01
warehouse =  PRAVEEN_WAREHOUSE
schedule = '1 minute'
as
insert into cust_tree values('level-1','praveen')

create or replace task child_task_01
warehouse =  PRAVEEN_WAREHOUSE
after parent_task_01
as
insert into cust_tree values('level-2 Child','cpr')

create or replace task taskchild_task_02
warehouse =  PRAVEEN_WAREHOUSE
after parent_task_01
as
insert into cust_tree values('level-2 Child','cpr')

show tasks

alter task PARENT_TASK_01 resume;
alter task CHILD_TASK_01 resume;
alter task TASKCHILD_TASK_02 resume;


alter task CHILD_TASK_01 suspend;
alter task PARENT_TASK_01 suspend;
alter task TASKCHILD_TASK_02 suspend;
alter task TASK_01 suspend;
alter task TASK_CLONE suspend;

select * from table(information_schema.task_history())




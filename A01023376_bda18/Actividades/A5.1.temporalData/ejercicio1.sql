CREATE TABLE COURSE
(course_number int NOT NULL,
title varchar(20) NOT NULL,
credits SMALLINT NOT NULL with default 3,
price decimal(6, 2) NOT NULL,
cstart date NOT NULL,
cend date NOT NULL,
period business_time(cstart, cend),
PRIMARY key(course_number, business_time WITHOUT overlaps))

insert into COURSE (course_number, title, credits, price, cstart, cend) values (1, 'DB', 5, 300, '2017-01-01', '2017-06-01')
insert into COURSE (course_number, title, credits, price, cstart, cend) values (2, 'DBA', 8, 800, '2017-06-01', '2017-12-01')
insert into COURSE (course_number, title, credits, price, cstart, cend) values (3, 'c++', 6, 550, '2018-01-01', '2018-06-01')
insert into COURSE (course_number, title, credits, price, cstart, cend) values (4, 'MetaProgramming', 4, 380, '2018-03-01', '2018-06-01')
insert into COURSE (course_number, title, credits, price, cstart, cend) values (5, 'AyMSS', 8, 800, '2017-08-01', '2017-09-01')


select * from COURSE for business_time as of '2017-05-01'

update COURSE set cstart = '2017-06-01', cend = '2017-12-01' where course_number = 2
update COURSE set cstart = '2018-01-01', cend = '2018-06-01' where course_number = 3
update COURSE FOR portion of business_time from '2018-04-01' TO '2018-05-01' set price = 200 where course_number = 4
update COURSE set price = 380 where course_number = 380

delete from course where course_number = 4
delete from course for portion of business_time from 'date' to 'date' where course_number = 3


CREATE TABLE COURSE_SYS (course_number int PRIMARY KEY NOT NULL, title varchar(20) NOT NULL, credits SMALLINT NOT NULL with default 3,
price decimal(7, 2) NOT NULL, sys_start TIMESTAMP(12) GENERATED ALWAYS AS ROW BEGIN NOT NULL,
sys_end TIMESTAMP(12) GENERATED ALWAYS AS ROW END NOT NULL, 
trans_start TIMESTAMP(12) GENERATED ALWAYS AS TRANSACTION START ID IMPLICITLY HIDDEN, period system_time (sys_start, sys_end))
CREATE TABLE COURSE_SYS_HISTORY LIKE COURSE_SYS

ALTER TABLE COURSE_SYS ADD versioning use HISTORY TABLE COURSE_SYS_HISTORY

insert into COURSE_SYS (course_number, title, credits, price) values (500, 'intro to sql', 2, 200.00)
insert into COURSE_SYS (course_number, title, credits, price) values (600, 'intro to ruby', 2, 250.00)
insert into COURSE_SYS (course_number, title, credits, price) values (650, 'advanced ruby', 2, 400.00)

select * from COURSE_SYS_HISTORY

update COURSE_SYS set price = 250.00 where course_number = 650
delete from COURSE_SYS where course_number = 600

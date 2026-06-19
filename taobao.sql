SET GLOBAL local_infile = 1;
USE taobao;

DROP TABLE IF EXISTS UserBehavior;

-- 创建一个新表
CREATE TABLE UserBehavior(
    user_id INT,
    item_id INT,
    category_id INT,
    behavior_type VARCHAR(20),
    timestamp BIGINT
);

-- 导入数据到数据库
LOAD DATA LOCAL INFILE 'D:/sql_exercise/UserBehavior.csv'
INTO TABLE UserBehavior
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- 改变字段名
alter table UserBehavior change timestamp timestamps bigint;
desc userbehavior;

-- 检查缺失值
select * from userbehavior where user_id is null;
select * from userbehavior where item_id is null;
select * from userbehavior where category_id is null;
select * from userbehavior where behavior_type is null;
select * from userbehavior where timestamps is null;


-- 新建临时表，存入前1000条数据
create temporary table sqmple_1000
select * from userbehavior limit 1000;

-- 新建普通永久表存放1000条样本
create table sample_1000 LIKE sqmple_1000;
insert into sample_1000 select * from sqmple_1000;

-- 检查重复值
select user_id,item_id,timestamps from sqmple_1000
group by user_id,item_id,timestamps
having count(*)>1;

-- 去重
alter table sqmple_1000 add id int first;
select * from sqmple_1000 limit 5;
alter table sqmple_1000 modify id int primary key auto_increment;

delete t1
from sample_1000 t1,sample_1000 t2
WHERE
  t1.user_id = t2.user_id
  AND t1.item_id = t2.item_id
  AND t1.timestamps = t2.timestamps
  AND t1.id>t2.id;

-- 新增日期:date time hour
alter table sample_1000 add datetimes TIMESTAMP(0);
update sample_1000 set datetimes=FROM_UNIXTIME(timestamps);
select * from sample_1000 limit 10;

-- 从日期里截取日期,时间,小时
alter table sample_1000 add dates char(10);
alter table sample_1000 add times char(8);
alter table sample_1000 add hours char(2);
update sample_1000 set dates=substring(datetimes,1,10);
update sample_1000 set times=substring(datetimes,12,8);
update sample_1000 set hours=substring(datetimes,12,2);
select * from sample_1000 limit 5;

-- 去除异常值
select max(datetimes),min(datetimes) from sample_1000;
-- max
-- 2017-12-03 23:59:13
-- min	
-- 2017-11-25 00:00:41
delete from sample_1000
where datetimes < '2017-11-25 00:00:41'
or datetimes >'2017-12-03 23:59:13'

desc sample_1000;


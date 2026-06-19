-- 统计各类行为用户数
select behavior_type,
       count(distinct(user_id)) as user_num
from sample_1000
group by behavior_type
order by behavior_type;

-- 存储
create table behavior_user_num(
behavior_type varchar(5),
user_num int);

-- 插入
insert into behavior_user_num
select behavior_type,
       count(distinct(user_id)) as user_num
from sample_1000
group by behavior_type
order by behavior_type;

-- 转化率分析(0.6364)
select * from behavior_user_num
select 7/11

-- 统计各类行为数量
select behavior_type
,count(*) as user_num
from sample_1000
group by behavior_type
order by behavior_type

-- 保存数据
create table behavior_num(
bahavior_type varchar(5),
behavior_num int);

insert into behavior_num
select behavior_type,
       count(*) as user_num
from sample_1000
group by behavior_type
order by behavior_type;

-- 计算购买率(buy/pv)(大约为0.025%)
select * from behavior_num;
select 23/906;

-- 计算加购率(cart/pv)(大约为0.03%)
select 28/906;

-- 计算收藏率(fav/pv)(大约为0.04%)
select 43/906;
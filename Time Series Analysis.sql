-- 统计一小时行为
select dates,hours
,count(if(behavior_type='pv',behavior_type,null)) as `pv`
,count(if(behavior_type='cart',behavior_type,null)) as `cart`
,count(if(behavior_type='fav',behavior_type,null)) as `fav`
,count(if(behavior_type='buy',behavior_type,null)) as `buy`
from sample_1000
group by dates,hours
order by dates,hours;

-- 创建空表准备插入数据
create table date_hour_behavior(
dates char(10),
hours char(2),
pv int,
cart int,
fav int,
buy int);

-- 插入数据
insert into date_hour_behavior
select dates,hours
,count(if(behavior_type='pv',behavior_type,null)) as `pv`
,count(if(behavior_type='cart',behavior_type,null)) as `cart`
,count(if(behavior_type='fav',behavior_type,null)) as `fav`
,count(if(behavior_type='buy',behavior_type,null)) as `buy`
from sample_1000
group by dates,hours
order by dates,hours;


-- 页面浏览次数page view(pv)
select dates,count(*)as'pv'
from sample_1000
where behavior_type='pv'
group by dates;

-- 独立访客数unique visitor(uv)
select dates,count(distinct user_id) as 'uv'
from sample_1000
where behavior_type='pv'
group by dates;

-- 一条语句查出pv,uv,pv/uv(浏览深度:保留1位小数)
select dates
,count(*) 'pv'
,count(distinct user_id) 'uv'
,round(count(*)/count(distinct user_id),1) 'pv/uv'
from sample_1000
where behavior_type='pv'
group by dates; 

-- 创建一张统计表pu_uv_puv
create table pv_uv_puv(
dates char(10),
pv int(9),
uv int(9),
puv decimal(10,1)
);

-- 将数据插入表中
insert into pv_uv_puv
select dates
,count(*) 'pv'
,count(distinct user_id) 'uv'
,round(count(*)/count(distinct user_id),1) 'pv/uv'
from sample_1000
where behavior_type='pv'
group by dates; 

select * from pv_uv_puv

-- 最近购买时间
select user_id,
max(dates) as 'recent_purchase_time'
from sample_1000
where behavior_type='buy'
group by user_id
order by recent_purchase_time;

-- 购买次数
select user_id,
count(user_id) as 'purchase_cnt'
from sample_1000
where behavior_type='buy'
group by user_id;

-- 统一
select user_id,
max(dates) as 'rencent_purchase_time',
count(user_id) as 'purchase_cnt'
from sample_1000
where behavior_type='buy'
group by user_id;

-- 存储
drop table if exists rmf_model;
create table rmf_model(
    user_id int,
    purchase_cnt int,
    recent_purchase_time char(10)
);

insert into rmf_model
select  
    user_id,
    count(user_id) as purchase_cnt,
    max(dates) as recent_purchase_time
from sample_1000
where behavior_type='buy'
group by user_id;

-- 新增用户分层字段 class
alter table rfm_model add column class varchar(40);

-- 根据R、F分数划分用户分层
update rfm_model
set class = case
    when fscore>@f_avg and rscore>@r_avg then '价值用户'
    when fscore>@f_avg and rscore<@r_avg then '保持用户'
    when fscore<@f_avg and rscore>@r_avg then '发展用户'
    when fscore<@f_avg and rscore<@r_avg then '挽留用户'
end;

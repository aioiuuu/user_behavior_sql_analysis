create view user_behavior_view as
select user_id,item_id,
count(if(behavior_type='pv',behavior_type,null)) 'pv',
count(if(behavior_type='fav',behavior_type,null)) 'fav',
count(if(behavior_type='cart',behavior_type,null)) 'cart',
count(if(behavior_type='buy',behavior_type,null)) 'buy'
from sample_1000
group by user_id,item_id;

-- 用户行为标准化
create view user_behavior_standard as
select 
    user_id,
    item_id,
    (case when pv>0 then 1 else 0 end) as is_pv,
    (case when fav>0 then 1 else 0 end) as is_fav,
    (case when cart>0 then 1 else 0 end) as is_cart,
    (case when buy>0 then 1 else 0 end) as is_buy
from user_behavior_view;

-- 购买路径类型
create view user_behavior_path as
select *,
concat(is_pv,is_fav,is_cart,is_buy) as purchase_path
from user_behavior_standard
where user_behavior_standard.is_buy>0;

-- 统计各类购买路径的数量
create view path_count as 
select purchase_path,
count(*) as num
from user_behavior_path
group by purchase_path
order by num desc

-- 浏览后直接购买的人最多
create table path_explain(
path_type char(4),
description varchar(40));


insert into path_explain
values('0001','direct_buy'),
('1001','view_then_buy'),
('0011','cart_then_buy'),
('1011','view_cart_then_buy'),

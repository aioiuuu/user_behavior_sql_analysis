-- 商品转化率分析(购买商品的人数/浏览该商品的人数)
select item_id,
count(if(behavior_type='pv',behavior_type,null)) as 'pv',
count(if(behavior_type='cart',behavior_type,null)) as 'cart',
count(if(behavior_type='fav',behavior_type,null)) as 'fav',
count(if(behavior_type='buy',behavior_type,null)) as 'buy',
count(distinct if(behavior_type='buy',user_id,null))/count(distinct if(behavior_type='pv',user_id,null)) as 'conversion_rate'
from sample_1000
group by item_id
order by conversion_rate desc
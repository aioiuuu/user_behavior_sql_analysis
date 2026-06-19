select category_id,
count(if(behavior_type='pv',behavior_type,null)) 'class_view'
from sample_1000
group by category_id 
order by class_view desc;

select item_id,
count(if(behavior_type='pv',behavior_type,null)) 'item_view'
from sample_1000
group by item_id
order by item_view desc;

 
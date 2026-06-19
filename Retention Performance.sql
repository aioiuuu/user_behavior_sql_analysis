select user_id,dates 
from sample_1000
group by user_id,dates;

-- 自关联 
SELECT * FROM
(
    SELECT user_id, dates
    FROM sample_1000
    GROUP BY user_id, dates
) a,
(
    SELECT user_id, dates
    FROM sample_1000
    GROUP BY user_id, dates
) b
WHERE a.user_id = b.user_id
  AND a.dates < b.dates;
  
  
-- 留存数
select 
    a.dates,
    count(if(datediff(b.dates,a.dates)=1, b.user_id, null)) as 'Next Day Retention Users',
    count(if(datediff(b.dates,a.dates)=0, b.user_id, null)) as 'Daily Active Users'
from
(
    select user_id, dates 
    from sample_1000
    group by user_id, dates
) a,
(
    select user_id, dates
    from sample_1000
    group by user_id, dates
) b
where 
    a.user_id = b.user_id 
    and a.dates <= b.dates
group by a.dates;


-- 留存率
select 
    a.dates,
    count(if(datediff(b.dates,a.dates)=1, b.user_id, null))/count(if(datediff(b.dates,a.dates)=0, b.user_id, null))    as 'next_day_retention_rate'
from
(
    select user_id, dates 
    from sample_1000
    group by user_id, dates
) a,
(
    select user_id, dates
    from sample_1000
    group by user_id, dates
) b
where 
    a.user_id = b.user_id 
    and a.dates <= b.dates
group by a.dates;


-- 建表保存分析结果
create table retention_rate(
dates char(10),
retention_1 float
);

-- 将数据插入保存表中
insert into retention_rate
select 
    a.dates,
    count(if(datediff(b.dates,a.dates)=1, b.user_id, null))/count(if(datediff(b.dates,a.dates)=0, b.user_id, null))    as 'next_day_retention_rate'
from
(
    select user_id, dates 
    from sample_1000
    group by user_id, dates
) a,
(
    select user_id, dates
    from sample_1000
    group by user_id, dates
) b
where 
    a.user_id = b.user_id 
    and a.dates <= b.dates
group by a.dates;

-- 跳失率(在采样数据中为0)
select count(*)
from
(
select user_id 
from sample_1000
group by user_id
having count(behavior_type)=1
)a
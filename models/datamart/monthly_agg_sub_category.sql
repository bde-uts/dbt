select
date_trunc('month', date)::date as month,
sub_category_description ,
count(distinct order_id) as total_orders,
sum(price) as total_sales
from {{ ref('facts_orders') }}
group by 1,2
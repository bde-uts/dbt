{{
    config(
        unique_key='order_id'
    )
}}

with check_dimensions as
(select 
	order_id,
	date,
	case when brand_id in (select distinct brand_id from {{ ref('brand_stg') }}) then brand_id else 0 end as brand_id,
	case when category_id in (select distinct category_id from {{ ref('category_stg') }}) then category_id else 0 end as category_id,
	case when sub_category_id in (select distinct sub_category_id from {{ ref('sub_category_stg') }}) then sub_category_id else 0 end as sub_category_id,
	price
from {{ ref('orders_stg') }})

select 
	a.order_id, 
	a.date,
	b.brand_description, 
	c.category_description, 
	d.sub_category_description,
	a.price
from check_dimensions a 
left join staging.brand_stg b  on a.brand_id = b.brand_id and a.date::timestamp between b.dbt_valid_from and coalesce(b.dbt_valid_to, '9999-12-31'::timestamp) 
left join staging.category_stg c  on a.category_id = c.category_id and a.date::timestamp between b.dbt_valid_from and coalesce(b.dbt_valid_to, '9999-12-31'::timestamp) 
left join staging.sub_category_stg d  on a.sub_category_id = d.sub_category_id and a.date::timestamp between b.dbt_valid_from and coalesce(b.dbt_valid_to, '9999-12-31'::timestamp) 
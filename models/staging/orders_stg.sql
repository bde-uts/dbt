{{
    config(
        unique_key='order_id'
    )
}}

with

source  as (

    select * from {{source('raw','facts')}}

),

renamed as (
    select
        order_id,
        to_date(date,'DD/MM/YY')  as date,
        category_id,
        subcategory_id as sub_category_id,
        brand_id,
        price
    from source
)

select * from renamed

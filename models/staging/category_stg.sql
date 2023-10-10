{{
    config(
        unique_key='category_id'
    )
}}

with

source  as (

    select * from {{ ref('category_snapshot') }}

),

renamed as (
    select
        id as category_id,
        category as category_description,
        case when dbt_valid_from = (select min(dbt_valid_from) from source) then '1900-01-01'::timestamp else dbt_valid_from end as dbt_valid_from,
        dbt_valid_to
    from source
),

unknown as (
    select 
        0 as category_id,
        'unknown' as category_description,
        '1900-01-01'::timestamp  as dbt_valid_from,
        null::timestamp as dbt_valid_to

)
select * from unknown
union all 
select * from renamed
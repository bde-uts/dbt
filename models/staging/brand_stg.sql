{{
    config(
        unique_key='brand_id'
    )
}}

with

source  as (

    select * from {{ ref('brand_snapshot') }}

),

renamed as (
    select
        id as brand_id,
        brand as brand_description,
        case when dbt_valid_from = (select min(dbt_valid_from) from source) then '1900-01-01'::timestamp else dbt_valid_from end as dbt_valid_from,
        dbt_valid_to
    from source
),

unknown as (
    select 
        0 as brand_id,
        'unknown' as brand_description,
        '1900-01-01'::timestamp  as dbt_valid_from,
        null::timestamp as dbt_valid_to

)
select * from unknown
union all 
select * from renamed
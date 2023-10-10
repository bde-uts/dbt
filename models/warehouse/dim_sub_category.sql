{{
    config(
        unique_key='brand_id'
    )
}}

select * from {{ ref('brand_stg') }}
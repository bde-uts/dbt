{{
    config(
        unique_key='sub_category_id'
    )
}}

select * from {{ ref('sub_category_stg') }}
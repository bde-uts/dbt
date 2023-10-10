{{
    config(
        unique_key='category_id'
    )
}}

select * from {{ ref('category_stg') }}
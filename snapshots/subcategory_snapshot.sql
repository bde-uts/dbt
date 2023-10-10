{% snapshot subcategory_snapshot %}

{{
        config(
          target_schema='raw',
          strategy='check',
          unique_key='id',
          check_cols=['id', 'sub_category'],
        )
    }}

select * from {{ source('raw', 'subcategory') }}

{% endsnapshot %}
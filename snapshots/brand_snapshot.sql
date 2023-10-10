{% snapshot brand_snapshot %}

{{
        config(
          target_schema='raw',
          strategy='check',
          unique_key='id',
          check_cols=['id', 'brand'],
        )
    }}

select * from {{ source('raw', 'brand') }}

{% endsnapshot %}
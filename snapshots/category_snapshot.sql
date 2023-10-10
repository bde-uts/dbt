{% snapshot category_snapshot %}

{{
        config(
          target_schema='raw',
          strategy='check',
          unique_key='id',
          check_cols=['id', 'category'],
        )
    }}

select * from {{ source('raw', 'category') }}

{% endsnapshot %}
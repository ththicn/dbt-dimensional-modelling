with
    stg__product as (select * from {{ ref("product") }}),

    stg__product_subcategory as (select * from {{ ref("product_subcategory") }}),

    stg__product_category as (select * from {{ ref("product_category") }})

select
    {{ dbt_utils.generate_surrogate_key(["stg__product.product_id"]) }} as product_key,
    stg__product.product_id,
    stg__product.name as product_name,
    stg__product.product_number,
    stg__product.color,
    stg__product.class,
    stg__product_subcategory.name as product_subcategory_name,
    stg__product_category.name as product_category_name
from stg__product
left join
    stg__product_subcategory
    on stg__product.product_subcategory_id
    = stg__product_subcategory.product_subcategory_id
left join
    stg__product_category
    on stg__product_subcategory.product_category_id
    = stg__product_category.product_category_id

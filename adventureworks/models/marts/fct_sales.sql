with
    stg__sales_order_header as (
        select
            sales_order_id,
            customer_id,
            credit_card_id,
            ship_to_address_id,
            status as order_status,
            cast(order_date as date) as order_date
        from {{ ref("sales_order_header") }}
    ),

    stg__sales_order_detail as (
        select
            sales_order_id,
            sales_order_detail_id,
            product_id,
            order_qty,
            unit_price,
            unit_price * order_qty as revenue
        from {{ ref("sales_order_detail") }}
    )

select
    {{
        dbt_utils.generate_surrogate_key(
            ["stg__sales_order_detail.sales_order_id", "sales_order_detail_id"]
        )
    }} as sales_key,
    {{ dbt_utils.generate_surrogate_key(["product_id"]) }} as product_key,
    {{ dbt_utils.generate_surrogate_key(["customer_id"]) }} as customer_key,
    {{ dbt_utils.generate_surrogate_key(["credit_card_id"]) }} as credit_card_key,
    {{ dbt_utils.generate_surrogate_key(["ship_to_address_id"]) }} as ship_address_key,
    {{ dbt_utils.generate_surrogate_key(["order_status"]) }} as order_status_key,
    {{ dbt_utils.generate_surrogate_key(["order_date"]) }} as order_date_key,
    stg__sales_order_detail.sales_order_id,
    stg__sales_order_detail.sales_order_detail_id,
    stg__sales_order_detail.unit_price,
    stg__sales_order_detail.order_qty,
    stg__sales_order_detail.revenue
from stg__sales_order_detail
inner join
    stg__sales_order_header
    on stg__sales_order_detail.sales_order_id = stg__sales_order_header.sales_order_id

with
    stg__sales_order_header as (
        select distinct credit_card_id
        from {{ ref("sales_order_header") }}
        where credit_card_id is not null
    ),

    stg__credit_card as (select * from {{ ref("credit_card") }})

select
    {{ dbt_utils.generate_surrogate_key(["stg__sales_order_header.credit_card_id"]) }}
    as credit_card_key,
    stg__sales_order_header.credit_card_id,
    stg__credit_card.card_type
from stg__sales_order_header
left join
    stg__credit_card
    on stg__sales_order_header.credit_card_id = stg__credit_card.credit_card_id

with
    stg__customer as (
        select customer_id, person_id, store_id from {{ ref("customer") }}
    ),

    stg__person as (
        select
            business_entity_id,
            concat(
                coalesce(first_name, ''),
                ' ',
                coalesce(middle_name, ''),
                ' ',
                coalesce(last_name, '')
            ) as full_name
        from {{ ref("person") }}
    ),

    stg__store as (
        select business_entity_id as store_business_entity_id, store_name
        from {{ ref("store") }}
    )

select
    {{ dbt_utils.generate_surrogate_key(["stg__customer.customer_id"]) }}
    as customer_key,
    stg__customer.customer_id,
    stg__person.business_entity_id,
    stg__person.full_name,
    stg__store.store_business_entity_id,
    stg__store.store_name
from stg__customer
left join stg__person on stg__customer.person_id = stg__person.business_entity_id
left join stg__store on stg__customer.store_id = stg__store.store_business_entity_id

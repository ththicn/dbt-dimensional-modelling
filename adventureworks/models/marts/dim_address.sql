with
    stg__address as (select * from {{ ref("address") }}),

    stg__state_province as (select * from {{ ref("state_province") }}),

    stg__country_region as (select * from {{ ref("country_region") }})

select
    {{ dbt_utils.generate_surrogate_key(["stg__address.address_id"]) }} as address_key,
    stg__address.address_id,
    stg__address.city as city_name,
    stg__state_province.name as state_name,
    stg__country_region.name as country_name
from stg__address
left join
    stg__state_province
    on stg__address.state_province_id = stg__state_province.state_province_id
left join
    stg__country_region
    on stg__state_province.country_region_code = stg__country_region.country_region_code

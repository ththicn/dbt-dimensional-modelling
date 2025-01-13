with stg__date as (select * from {{ ref("date") }})

select {{ dbt_utils.generate_surrogate_key(["stg__date.date_day"]) }} as date_key, *
from stg__date

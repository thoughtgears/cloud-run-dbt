{{ config(
    materialized = 'table',
) }}

with parsed_json
as
(
  select parse_json(json, wide_number_mode =>'round') as json_data
  from {{ source('input_data', 'pokemon_data_raw') }}
)

select
   lax_int64(json_data.data.id) as id
  ,string(json_data.name) as name
  ,lax_int64(json_data.data.base_experience) as base_experience
  ,lax_int64(json_data.data.height) as height
  ,lax_int64(json_data.data.weight) as weight
from parsed_json
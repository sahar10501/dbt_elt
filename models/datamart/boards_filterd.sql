{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('boards_ab3') }}
select
    {{ adapter.quote('id') }},
    url,
    {{ adapter.quote('desc') }},
    {{ adapter.quote('name') }},
    closed,
    idtags,
    limits,
    descdata,
    labelnames,
    memberships,
    idboardsource,
    idorganization,
    datelastactivity,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_boards_hashid
from {{ ref('boards_ab3') }}
-- boards from {{ source('public', '_airbyte_raw_boards') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}


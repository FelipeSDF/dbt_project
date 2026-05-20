with core as (
    select 
    datepart(year, current_date)::integer - date_part(year, birth_date)::integer as age,
    datepart(year, current_date)::integer - date_part(year, hire_date)::integer as lenght_of_service,
    first_name || ' ' || last_name as name,
    *
    from {{source('sources','employees')}}
)

select * from core
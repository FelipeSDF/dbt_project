with prod as (
select 
ct.category_name,
sp.company_name as suppliers,
pd.product_name,
pd.unit_price,
pd.product_id
from {{source('sources','products')}} as pd
left join {{source('sources','suppliers')}} as sp on (sp.supplier_id = pd.supplier_id)
left join {{source('sources','categories')}} as ct on (ct.category_id - pd.category_id)
), 
orddetai as (
    select pd.*, od.order_id, od.quantity, od.discount
    from {{ref('order_details')}} as od
    left join prod pd on (pd.product_id = od.product_id)

),
ordrs as (
    select 
    ord.order_date,
    ord.order_id,
    cs.company_name customer,
    em.name employee,
    em.age,
    em.lenght_of_service
    from {{source('sources','orders')}} as ord
    left join {{ref('customers')}} as cs on (ord.customer_id = cs.customer_id)
    left join {{ref('employees')}} as em on (ord.employee_id = em.employee_id)
    left join {{source('sources','shippers')}} sh on (ord.ship_via = sh.shipper_id)
),
finaljoin as (
    select 
    od.*,
    ord.order_date,
    ord.customer,
    ord.employee,
    ord.age,
    ord.lenght_of_service
    from orddetai as od
    inner join ordrs as ord on (od.order_id = ord.order_id)
)

select * from finaljoin 
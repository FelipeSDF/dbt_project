select
od.order_id,
pd.unit_price,
pd.product_id,
od.quantity,
pd.product_name,
pd.supplier_id,
pd.category_id,
od.unit_price* od.quantity as total,
(pd.unit_price * od.quantity) - total as discount 
from {{source('sources','order_details')}} od
left join {{source('sources','products')}} pd on (pd.product_id = od.product_id)
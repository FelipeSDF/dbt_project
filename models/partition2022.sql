select * from {{ref('joins')}} as joins 
where date_part(year, joins.order_date) = 2022
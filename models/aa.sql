WITH customers AS (
  SELECT
    *
  FROM {{ ref('my_new_project', 'customers') }}
  LIMIT 10
), filter AS (
  SELECT
    *
  FROM customers
  WHERE
    customer_id LIKE '%A'
), aa_sql AS (
  SELECT
    *
  FROM filter
)
SELECT
  *
FROM aa_sql
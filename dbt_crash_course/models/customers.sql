with customers as (
    select id,
           first_name,
           last_name
    from `dbt-tutorial`.jaffle_shop.customers
),

orders as (
    select id,
           user_id,
           order_date,
           status
    from `dbt-tutorial`.jaffle_shop.orders
),

customer_order as (
    select
           user_id,
           min(order_date) as first_order,
           max(order_date) as most_recent_order,
           count(id) as number_of_orders
    from orders
    group by user_id
)

final as (
    select
        customer.id,
        customer.first_name,
        customer.last_name,
        customer_order.first_order,
        customer_order.most_recent_order,
        customer_order.num_of_orders
    from customers a
    left join customer_order b
    on a.id=b.user_id
)

select * from final
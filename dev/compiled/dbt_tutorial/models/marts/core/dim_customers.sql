with customers as (

    select * from `wendy-dbt-training-sandbox`.`dev_wlee`.`stg_customers`

),

orders as (

    select * from `wendy-dbt-training-sandbox`.`dev_wlee`.`fct_orders`
),

customer_orders as (

    select

        orders.customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(amount) as lifetime_value

    from orders

    group by 1

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        customer_orders.lifetime_value as lifetime_value

    from customers

    left join customer_orders 
    on customers.customer_id = customer_orders.customer_id

)

select * from final
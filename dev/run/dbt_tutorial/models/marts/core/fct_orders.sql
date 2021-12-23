

  create or replace table `wendy-dbt-training-sandbox`.`dev_wlee`.`fct_orders`
  
  
  OPTIONS()
  as (
    with orders as (

    select * from `wendy-dbt-training-sandbox`.`dev_wlee`.`stg_orders`

),

payments as (

    select * from `wendy-dbt-training-sandbox`.`dev_wlee`.`stg_payments`

),

order_payments as (

    select

        order_id,
        sum(case 
                when status = 'success' then amount 
            end) as amount

    from payments
    group by 1

),

final as (

    select 
        
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce(order_payments.amount, 0) as amount

    from orders

    left join order_payments
    on orders.order_id = order_payments.order_id

)

select * from final
  );
    
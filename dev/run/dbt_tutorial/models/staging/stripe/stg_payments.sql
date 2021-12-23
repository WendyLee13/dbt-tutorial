

  create or replace view `wendy-dbt-training-sandbox`.`dev_wlee`.`stg_payments`
  OPTIONS()
  as with payments as (

    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        created as created_at,

        -- amount is stored in cents, convert to dollars
        amount / 100 as amount,
        status

    from dbt-tutorial.stripe.payment

)

select * from payments;


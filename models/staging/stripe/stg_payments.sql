with payments as (

    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        created as created_at,

        -- amount is stored in cents, convert to dollars
        amount / 100 as amount,
        status

    from {{ source('stripe','payment') }}

)

select * from payments
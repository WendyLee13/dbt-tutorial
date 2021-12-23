

  create or replace view `wendy-dbt-training-sandbox`.`dev_wlee`.`my_second_dbt_model`
  OPTIONS()
  as -- Use the `ref` function to select from other models

select *
from `wendy-dbt-training-sandbox`.`dev_wlee`.`my_first_dbt_model`
where id = 1;


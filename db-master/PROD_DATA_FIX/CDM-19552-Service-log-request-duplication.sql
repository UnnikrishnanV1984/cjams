UPDATE
  tb_service_purchase_authorization
SET
  delete_sw = 'Y',
  update_ts = now(),
  update_user_id = 'CDM-19552'
WHERE
  authorization_id = 1812689;
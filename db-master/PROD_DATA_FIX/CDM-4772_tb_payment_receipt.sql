UPDATE cjams.tb_payment_receipt
SET approval_status_cd='3047', update_user_id='CDM-4772', update_ts=now()
WHERE receipt_id in (1011878, 1011572, 1011808) and payment_method_cd='16';

-- original objectid='1011571'
UPDATE cjams.routing
SET objectid='1011572', updatedby='CDM-4772', updatedon=now()
WHERE routingid='f14770ac-819e-420b-a1ab-59abf6c71a52' and eventcode='RVRSL';

-- original objectid='9343'
UPDATE cjams.routing
SET objectid='1011808', updatedby='CDM-4772', updatedon=now()
WHERE routingid='04e4c0a5-47dc-4c47-8a57-442b300647eb' and eventcode='RVRSL';

-- original objectid='1011876'
UPDATE cjams.routing
SET objectid='1011878', updatedby='CDM-4772', updatedon=now()
WHERE routingid='3e81bf54-fe5b-4f2d-a718-b82ff33bffc6' and eventcode='RVRSL';


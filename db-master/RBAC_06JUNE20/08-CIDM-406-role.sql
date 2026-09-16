UPDATE cjams."role"
SET updatedon=now(), description='Admin Audit Monitor CQI,CW'
WHERE id=126;

UPDATE cjams."role"
SET updatedon=now(), openamrole='CJAMS_CW_OFC_ADMINISTRATOR'
WHERE id=134;

UPDATE cjams."role"
SET updatedon=now(), openamrole='CJAMS_CW_IT_ADMINISTRATOR'
WHERE id=142;

UPDATE cjams."role"
SET updatedon=now(), openamrole='CJAMS_IVE_ADMIN'
WHERE id=145;

UPDATE cjams."role"
SET updatedon=now(), openamrole='CJAMS_IVE_ADMIN_ASSISTANT'
WHERE id=146;


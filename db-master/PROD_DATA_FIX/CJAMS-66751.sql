/*
Issue Description:CJAMS-66751-PAYMENT-SYSTEM ADJUSTMENT AND MARCH ARE NOT GENERATING.
Root cause: Finance Under/over batch did not run on 03/20, 03/21 and 03/22 weekend due to the Control-M scheduler issue
Fix provided: Fix to run finace batch on 3/20,3/21/3/22
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/



-- Finance Under/over batch did not run on 03/20, 03/21 and 03/22 weekend due to the Control-M scheduler issue
select * from cjams.SP_BATCH_PROV_CHECKLIST('U','2026-03-19'::date);
select * from cjams.SP_UNDER_OVER_ADOPTION('2026-03-19'::date);
select * from cjams.SP_UNDER_OVER_GAP('2026-03-19'::date);
select * from cjams.SP_UNDER_OVER_PVT('2026-03-19'::date);
select * from cjams.SP_UNDER_OVER_PUB('2026-03-19'::date);
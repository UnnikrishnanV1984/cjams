/*
Issue Description:CJAMS-66869 1. We will remove the latest subsidy rate slab 
2. Revert the switch provider to original
Category/Module: GAP Subsidy 
Fix provided: Data fix has been done to remove subsidy rate.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CJAMS-66869',
	updatedon = now()
where gapagreementrateid = '4c4d5cc5-19da-43c2-b5d4-8bed97db76b4'
	and activeflag = 1 ;


-- INSERT INTO cjams.providerswitchinfo
-- (providerswitchid, activeflag, objectid, objecttype, approvalstatus, oldproviderid, newproviderid, requestedby, approvedby, approvaldate, decisiondate, insertedby, insertedon, updatedby, updatedon)
-- VALUES('10868176-9e44-4203-9985-e4a528dbce2a'::uuid, 1, 'c657ad25-01d8-42c0-a883-7072970f3840'::uuid, 'GAP', 'Approved', '5076484', '6285700', '73999176-0c94-4d08-9ef2-0efe966ce506', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2026-04-02 16:06:29.948', '2026-03-24 11:37:55.388', '73999176-0c94-4d08-9ef2-0efe966ce506', '2026-03-24 11:37:55.388', 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f', '2026-04-02 16:06:29.948');

DELETE FROM cjams.providerswitchinfo
WHERE providerswitchid='10868176-9e44-4203-9985-e4a528dbce2a';

update guardianship
set switchprovider = false,guardianoneproviderid = 5076484, effectiveswitchdate = null, switchproviderreason = '',  guardianoneid = '5076484', guardianonename = 'Richard Porter', updatedby='CJAMS-66869', updatedon = now()
where gapid='8795f392-6145-4f1b-9930-b3b8bb708b28' and activeflag = 1;



  update gapratesrevision 
set  activeflag = 0,
	approvaldate = now(),
	updatedby = 'CJAMS-66869',
	updatedon = now()
where gaprateid = '4c4d5cc5-19da-43c2-b5d4-8bed97db76b4' 
	and activeflag = 1 ;


    

  
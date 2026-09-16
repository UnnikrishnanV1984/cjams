/*
Issue Description:CJAMS-67247SUBSIDY PAYMENTS WILL NOT GENERATE
Category/Module: SUBSIDY PAYMENTS WILL NOT GENERATE
Root cause: 3249434: There is one rejected record in suspension which has stopped the payments from November
Fix provided: Data fix has been done remove the Rejected suspension record and triggered batch for payments to generate from December to april
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: 
Reason why no related code fix: N/A
*/



update gapsuspension
set activeflag = 0,
	updatedby = 'CJAMS-67247', 
	updatedon = now() 
where gapsuspensionid = '90aeeb54-4c5a-459e-9507-fe112c2b99a4'
	and activeflag = 1 ;

update gapsuspensionrevision
set activeflag = 0,
	updatedby = 'CJAMS-67247', 
	updatedon = now() 
where suspensionid = '90aeeb54-4c5a-459e-9507-fe112c2b99a4'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CJAMS-67247',
	updatedon = now() 
where objectid = '90aeeb54-4c5a-459e-9507-fe112c2b99a4'
	and activeflag = 1 ;


--updating gapraterevision table to trigger finance batch.

update gapagreementrevision
set approvalDate = now(),
    updatedby = 'CJAMS-67247',
    updatedon = now()
where gapagreementid  = '0dfb2aa1-3130-41e8-8f25-671b393dcf0b' and activeflag=1;
/*
Issue Description: CJAMS-67119  delete this request
Category/Module: 
Root cause: User requested to remove the record from Case pending approval dashboard which is created by error
Fix provided: Data fix to to remove the record from Case pending approval dashboard which is created by error
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/


update routing
set activeflag = 0, updatedby = 'CJAMS-67119', updatedon = NOW()
where routingid = 'c9cb820b-924b-40ae-85a9-e86516460a33' and eventcode='SCCR'  and activeflag = 1;


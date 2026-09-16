/*
Issue Description: 211030012396:Subsidy Rate change from 33.15 to 1008 Screen 
Category/Module: Bug
Root cause: Due to data glitch caused user can only enter amount, but they do not have access to update or edit record.
Fix provided:DB queries to update record in tb_service_log table.
Data/Code fix ticket#: CJAMS-59070
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: data Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update gapagreementrate 
set paymentamout  = '1008',
	updatedby = 'CJAMS-59070',
	updatedon = now()
where gapagreementrateid in ('21496e9c-eae3-4d79-a57d-bb93d0de09d9','842d12d8-4c8d-4a04-9554-054d349b54b9')
	and activeflag = 1 ;
	
    
    update gapratesrevision  
set paymentamt  = '1008',
	updatedby = 'CJAMS-59070',
	updatedon = now(),approvaldate = now()
where gapratesrevisionid  in ('d19cdd89-af45-468d-bd8d-3ac0577ddd40',
'3bab2ecc-45db-4bc9-adcc-3e37703f8637',
'7a31791a-c065-4908-88d6-1650766b7a5b',
'7f3b3cbd-fe50-41ac-8b77-9573969788b7')
	and activeflag = 1 ;

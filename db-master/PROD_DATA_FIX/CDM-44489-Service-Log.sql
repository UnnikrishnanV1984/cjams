
/*
Issue Description:3305649:Unable to close case due to end dates of services. All the services have an "Actual" end date. Please advise. 
Root cause: During the resolution of CDM-26663, a data fix was applied on 2023-01-20 to remove a person from the service case # 3305649. however
, while performing the data fix,the service log and purchase authorization records were not reviewed.
Fix provided: DB query to udate tb_service_log.
Data/Code fix ticket#:CDM-44489
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:Internal Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--restore the person record with PID=  1738592   that was previously associated with service case #3305649.
update actorrelationship set activeflag = 1, updatedby = 'CDM-44489', updatedon = now() where intakeservicerequestactorid in (	
	select intakeservicerequestactorid 
	from intakeservicerequestactor
	where personid = 'fa48a050-7aa7-4a52-994e-c27d39f01a98' and intakeservicerequestactorid = 'b8fe3427-4b8e-4349-9005-55296a4ee5d6');	

update intakeservicerequestactor	
set activeflag = 1, updatedby = 'CDM-44489', updatedon = now()
where personid = 'fa48a050-7aa7-4a52-994e-c27d39f01a98'
and intakeservicerequestactorid = 'b8fe3427-4b8e-4349-9005-55296a4ee5d6';

update actor
set activeflag = 1,	updatedby = 'CDM-44489', updatedon = now()
where personid = 'fa48a050-7aa7-4a52-994e-c27d39f01a98' and actorid = 'c2be1383-b977-41e4-b462-7c5cffca1267';




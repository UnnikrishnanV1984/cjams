/*
   Issue Description: CDM-30209
   Category/ Module  : Persons tab head of the household
   Root cause: user added multiple times so the system did not take the primary as true
   Pull request# for code fix: 8780
   Reason why no related code fix: 
    requested a data fix to resolve
*/
update actor
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-30338'
where actorid ='1bae3afe-6e45-4097-a745-3c3eca9451e0';

update intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-30338'
where intakeservicerequestactorid= '0992f3c9-86ec-4ce0-9d03-e1cfa19aac74';

update personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-30338'
where personroleid  = '4ce520bb-4e02-4785-9369-0d2ddfcca9e4';

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-30338'
where actorrelationshipid ='0597eea6-08d9-43a5-8ddc-a394b865c4b6';


update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-30338',
	updatedon = now()
where personid = '83f30486-0e91-40bf-a4b6-5e2103516933'
	and objectid = '38744fe5-2431-4af7-9953-744530a92a11' 
	and activeflag = 1 ;
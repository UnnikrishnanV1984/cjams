/*
Issue Description: SSA/PO approved to remove the Persons (PID# 203751577) from this case entirely (CPS-IR : 241022707012).
Category/ Module: Removal
Root cause: Person (PID# 203751577) incorrect information was added to case  (CPS-IR : 241022707012) and need to be removed.
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-40909
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update 
    cjams.actor
set 
	activeflag = 0,
	updatedby = 'CDM-40909',
	updatedon = now()
where 
    actorid = '130af607-2e76-457c-a88e-b1df1c27262f' 
    and activeflag = 1;

update 
    cjams.intakeservicerequestactor
set 
	activeflag = 0,
	updatedby = 'CDM-40909',
	updatedon = now()
where 
    intakeservicerequestactorid = '38efe0ca-4219-4c1d-8e6d-358b68b326ac' 
    and activeflag = 1;

update 
    cjams.actorrelationship
set 
	activeflag = 0,
	updatedby = 'CDM-40909',
	updatedon = now()
where 
    actorrelationshipid = '3e91c340-e21c-446c-b2d0-71e9acefa5f1' 
    and activeflag = 1;

update 
    cjams.personrole
set 
	activeflag = 0,
	updatedby = 'CDM-40909',
	updatedon = now()
where 
    personroleid = '6f57c0ae-e02a-4248-83de-c5f1bdd9bbb6' 
    and activeflag = 1;

update 
    cjams.personroletype
set 
	activeflag = 0,
	updatedby = 'CDM-40909',
	updatedon = now()
where 
    personroletypeid = 'f0e66277-6747-439a-9b6f-bc6e3c6a073f' 
    and activeflag = 1;

update 
    cjams.personprogramarea
set 
	activeflag = 0,
	updatedby = 'CDM-40909',
	updatedon = now()
where 
    personprogramid = '9547a375-716d-461d-b42e-966ab4d1bd04' 
    and activeflag = 1;
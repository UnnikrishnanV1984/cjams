/*
 * CDM-41718
Issue Description: SSA/PO approved to remove the Persons (PID# 3312134) from this case entirely (CPS-IR : 241022916165).
Category/ Module: Removal
Root cause: Person (PID# 3312134) incorrect information was added to case  (CPS-IR : 241022916165) and need to be removed.
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-41718
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

/* Inspect:-
"objectid":"0b565e49-2269-4e58-9ab8-8640705f4f06",
"personid":"4eeb82c6-5793-4035-a817-7d810bbd7b8c",
"personprogramid": "ecd8b3a7-b917-4c52-af18-0cd7794190f5"
"intakeserviceid":"0b565e49-2269-4e58-9ab8-8640705f4f06"
*/

/*
select * from cjams.actor a where personid = '4eeb82c6-5793-4035-a817-7d810bbd7b8c' and intakenumber = 'I241013136526'
*/

update 
    cjams.actor
set 
	activeflag = 0,
	updatedby = 'CDM-41718',
	updatedon = now()
where 
    actorid = '3c8a459c-96fb-4e60-873d-37094e3e034e' 
    and activeflag = 1;

/*
select * from cjams.intakeservicerequestactor where personid = '4eeb82c6-5793-4035-a817-7d810bbd7b8c' and actorid = '3c8a459c-96fb-4e60-873d-37094e3e034e' and intakenumber = 'I241013136526'
*/
   
update 
    cjams.intakeservicerequestactor
set 
	activeflag = 0,
	updatedby = 'CDM-41718',
	updatedon = now()
where 
    intakeservicerequestactorid = '17537f0e-d487-4b28-b77d-798b71bca263' 
    and activeflag = 1;

/*
   select * from actorrelationship a where     intakeservicerequestactorid = '17537f0e-d487-4b28-b77d-798b71bca263';
*/
  
  update 
    cjams.actorrelationship
set 
	activeflag = 0,
	updatedby = 'CDM-41718',
	updatedon = now()
where 
    actorrelationshipid in ('648383bb-dc10-467b-abcc-ca92d5cc758f','bbae1c8a-ce50-4681-9361-2753093ce0f0')
    and activeflag = 1;

 
/*
   select * from cjams.personrole where personid = '4eeb82c6-5793-4035-a817-7d810bbd7b8c' and intakenumber = 'I241013136526' and activeflag =1;
*/
   
update 
    cjams.personrole
set 
	activeflag = 0,
	updatedby = 'CDM-41718',
	updatedon = now()
where 
    personroleid = '600d4698-4ed1-41c6-82f5-14abb927cf36' 
    and activeflag = 1;

/*
    select * from cjams.personroletype where     personroleid = '600d4698-4ed1-41c6-82f5-14abb927cf36'  and activeflag =1;
*/

update 
    cjams.personroletype
set 
	activeflag = 0,
	updatedby = 'CDM-41718',
	updatedon = now()
where 
    personroletypeid = 'bd38d980-453b-4a7c-8fb1-d644ebce4108' 
    and activeflag = 1;

update 
    cjams.personprogramarea
set 
	activeflag = 0,
	updatedby = 'CDM-41718',
	updatedon = now()
where 
    personprogramid = 'ecd8b3a7-b917-4c52-af18-0cd7794190f5' 
    and activeflag = 1;
/*
Issue Description: CDM-42677: 241022949973:The child, Eliza Miller, was incorrectly added to this CPS case. 
					The child was included in a provider maltreatment case with a childcare provider. 
					There needs to be 2 separate cases for this as this child is not part of the household she was added into by the worker. 
					Please remove the person card in this IR case: 241022949973
Category/Module: Persons tab
Root cause: The person was added by mistake to the case 241022949973
Fix provided: DB queries remove person from the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

/* Person Details to be removed
 * CJAMSPID: 204023929, Personid: '5a7d4963-8857-4015-a160-cfab62ab332f'
*/


/*
select * from cjams.actor where personid = '5a7d4963-8857-4015-a160-cfab62ab332f' 
	and intakeserviceid = 'b01c7a94-ee37-4ca3-b193-aabe194c5b13' 
	and activeflag = 1;
*/
update cjams.actor 
	set activeflag = 0, 
		updatedon = now(), 
		updatedby = 'CDM-42677'
	where actorid = '2bcfbe89-6578-4f55-a9b5-6e70f6c00b4e' 
		and activeflag = 1;

update cjams.intakeservicerequestactor 
	set activeflag =0,
		updatedon = now(),
		updatedby = 'CDM-42677'
	where intakeservicerequestactorid in ('39ea63db-b523-448d-b604-1000d015ecee') 
		and activeflag = 1;
		


update cjams.actorrelationship 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-42677'
	where intakeservicerequestactorid in ('39ea63db-b523-448d-b604-1000d015ecee')
		and activeflag = 1;


update cjams.personrole 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-42677'
	where personroleid  in ('01d4d970-3f41-4b85-9250-1fa27feba505') 
		and activeflag = 1;


update cjams.personroletype 
	set activeflag =0,
		updatedon = now(),
		updatedby ='CDM-42677'
	where personroletypeid  in ('49352fdd-21b1-456b-961f-0d9e2724f9b1') 
		and activeflag = 1;
		

update cjams.personprogramarea 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-42677'
	where personid = '5a7d4963-8857-4015-a160-cfab62ab332f' 
		and objectid = 'b01c7a94-ee37-4ca3-b193-aabe194c5b13'
		and activeflag = 1;
		

UPDATE contactparticipant
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-42677'
	WHERE contactparticipantid IN ('5ee90ea9-b810-4186-8074-6b7332f8a744')
		and activeflag = 1;		
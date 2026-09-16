/*
 Issue Description: CDM-37583
 Category/ Module : Person Relationship
 Case#: CW2870106
 Root cause: User requested to update the relation ship type from 'GodMother' to 'Paternal Grandparent'.
 Fix: Data fix applied to update relationship type.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */
select * from actorrelationship 
	where  intakeservicerequestactorid = 'b33a3a1a-eff8-462b-9fb9-f714294751e4' 
		and person1id = 'fc796c6e-62d1-44a5-82c4-13bdfdd1773e' 
		and person2id = 'fa113826-af49-40c6-be0b-36d09e526758'
		and activeflag = 1;

update actorrelationship 
	set relationshiptypekey = 'PRNTLGPRNT',
		updatedon = now(),
		updatedby = 'CDM-37583'
	where actorrelationshipid = 'cace0ee7-7364-4a64-84db-a68b3e3563ab';
/*
Issue Description: I241013165562:Can you please remove Zoe Holliday 204014589, who was was added to this case by mistake. She is no affiliation with this case/family.
Category/Module: HouseHold Members
Root cause: The person was added by mistake to intake I241013165562
Fix provided: DB queries remove person from the intake
Data/Code fix ticket#: CDM-42680
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

/* Person Details to be removed
 * CJAMSPID: 204014589, Personid: '8c8e6cf5-3822-413e-b8ee-fa71f72a3a02'
*/

--Deactivating person in actor
update actor
	set activeflag = 0, updatedby = 'CDM-42680', updatedon = now()
	where actorid in ( 'd9a7a5f7-ece3-4739-a9fc-4c6dd349feb2')
		and activeflag = 1;

--Deactivating peron in intakeservicerequestactor
update intakeservicerequestactor 
	set activeflag = 0, updatedby = 'CDM-42680', updatedon = now()
	where intakeservicerequestactorid in ( 'c48aef72-1790-4f26-8672-966f681d4c33')
		and activeflag = 1;

--No records in actorrelationship

--Deactivating person in personrole
update personrole 
	set activeflag = 0, updatedby = 'CDM-42680', updatedon = now()
	where personroleid in ('e38ead4a-92cb-4589-8f69-e43d65413a60') 
		and activeflag = 1;

update personroletype
	set activeflag = 0, updatedby = 'CDM-42680', updatedon = now()
	where personroleid in ('52ea71fb-5346-4f2d-a769-5d45855b0990')
		and activeflag = 1;

--No records in personprogramarea


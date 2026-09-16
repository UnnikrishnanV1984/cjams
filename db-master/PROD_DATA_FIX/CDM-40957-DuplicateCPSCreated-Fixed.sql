/*
Issue Description: User is not able to add the initial contact caregiver role for CJAMS PID# : 203821532. Case # 241022776347
Category/Module: Error
Root cause: Person data was being pulled from two different actor records for the same intakeservicerequest
Fix provided: DB query to switch the ICC person type actorid to the parent type
Data/Code fix ticket#: CDM-40957
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This error happened because a duplicate CPS case was created
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

-------------THIS DATAFIX IS NO LONGER REQUIRED------------
--Updating intakeservicerequestactor to reflect the same actorid
--update intakeservicerequestactor
--set actorid = '26e62f19-5c6b-4515-9fc7-9025aa8134a9', updatedby = 'CDM-40957', updatedon = now()
--where intakeservicerequestactorid = 'd2f8c53c-1e23-4c9b-8463-3210e711a63b' and activeflag = 1;

--Deactivating duplicate record of the person in actor
update actor
set activeflag = 0, updatedby = 'CDM-40957', updatedon = now()
where actorid = '57a248ba-2bbe-4472-b5e0-a45fe96bc7e2' and activeflag = 1;

--Deactivating duplicate records of the person in intakeservicerequestactor
update intakeservicerequestactor
set activeflag = 0, updatedby = 'CDM-40957', updatedon = now()
where intakeservicerequestactorid in ('9973dbed-3b51-4e1b-96d3-4efab2e68c28', 'e09b47b7-088e-491e-b0a1-23241554958f')
	and activeflag = 1;

--Deactivating duplicate records of the person in actorrelationship
update actorrelationship
set activeflag = 0, updatedby = 'CDM-40957', updatedon = now()
where actorrelationshipid in ('8bbb395c-60c5-4e02-a2b4-e03559845955', 'd1540439-f5fb-4b13-8408-2eb069513b74')
	and activeflag = 1;

--Deactivating duplicate record of the person in personrole
update personrole
set activeflag = 0, updatedby = 'CDM-40957', updatedon = now()
where personroleid = '61aa8585-4979-4139-be1a-c027104413e5' and activeflag = 1;
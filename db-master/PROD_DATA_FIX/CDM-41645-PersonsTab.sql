/*
Issue Description: SSA/Product Owner approved to remove the Client ID: 3835204 (CIARA T THOMAS) from CPS AR# 241022906358.
Category/Module: Error
Root cause: The person was incorrectly added to the AR case
Fix provided: DB queries remove person from the CPS case
Data/Code fix ticket#: CDM-41645
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating person in actor
update actor
set activeflag = 0, updatedby = 'CDM-41645', updatedon = now()
where actorid = '8e264708-1f66-4cbc-952e-74210525c4f4' and activeflag = 1;

--Deactivating peron in intakeservicerequestactor
update intakeservicerequestactor 
set activeflag = 0, updatedby = 'CDM-41645', updatedon = now()
where activeflag = 1 and intakeservicerequestactorid in (
'0236458a-1f15-4414-a525-b5ad734447df',
'1a89b77e-8ed9-4941-9c64-0a26e90128be',
'2424b0db-5008-4a63-950b-77ca22ab443f',
'c7423e37-b60e-4f88-951a-61bc66aab383');

--Deactivating person in actorrelationship
update actorrelationship
set activeflag = 0, updatedby = 'CDM-41645', updatedon = now()
where activeflag = 1 and actorrelationshipid in (
'9f7f3a9b-455f-4b8f-bbe9-84debe79736c',
'cec98afd-204b-432f-a24e-925a59deb31e',
'51c33053-b9fc-4abc-824a-8c6d4809c310');

--Deactivating person in personrole
update personrole 
set activeflag = 0, updatedby = 'CDM-41645', updatedon = now()
where personroleid = 'e39a04a1-ad17-408e-9683-7323940267c8' and activeflag = 1;

--Deactivating person in personprogramarea
update personprogramarea
set activeflag = 0, updatedby = 'CDM-41645', updatedon = now()
where personprogramid = '81cf2fba-4847-4750-8926-cbdca390899f' and activeflag = 1;
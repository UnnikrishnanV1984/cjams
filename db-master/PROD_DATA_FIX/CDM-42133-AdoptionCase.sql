/*
Issue Description: Please do the data fix to Screen Out the intake I241012097133 and delete the Adoption Case 241040302738.
Category/Module: Error
Root cause: Adoption case was opened in error
Fix provided: DB query to deactivate the adoption case and screenout the intake
Data/Code fix ticket#: CDM-42133
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating intakesnapshot
update intakesnapshot
set jsondata = jsonb_set(jsondata, '{DAType, DATypeDetail, 0, supDisposition}', '"ScreenOUT"', false),
	updatedby = 'CDM-42133', updatedon = now()
where intakesnapshotid = '18097571-4433-4420-9525-d0a492f8fbd4' and activeflag = 1;

--Updating routing
--UPDATE: Cannot add updatedby because that overwrites "Submitted to/Approved By" in submission history
update routing
set supervisordecision = 'screenout', intakerecommendation = 'scrnin', updatedby = '7ca5718d-cc3f-4884-934c-6769a4d00eed', updatedon = now()
where routingid = '1dcd7426-af87-4c43-911c-edf7f06ce892' and activeflag = 1;

--Updating adoptioncase
update adoptioncase
set activeflag = 0, updatedby = 'CDM-42133', updatedon = now()
where adoptioncaseid = 'd90c6d94-5537-43e9-ae0e-fa6c4fafdccb' and activeflag = 1;

--Updating adoptioncaseactor
update adoptioncaseactor
set activeflag = 0, updatedby = 'CDM-42133', updatedon = now()
where adoptioncaseactorid = '4af4344b-4a70-4fa9-bf7a-70d79475469e' and activeflag = 1;

--Updating personprogramarea
update personprogramarea
set activeflag = 0, updatedby = 'CDM-42133', updatedon = now()
where personprogramid = '9274dc65-ceac-45f4-9b54-074d31bcf7ca' and activeflag = 1;
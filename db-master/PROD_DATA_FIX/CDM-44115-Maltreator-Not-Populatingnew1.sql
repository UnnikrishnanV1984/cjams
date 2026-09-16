/*
Issue Description: Need analysis and fix to select all the 3 roles for the client and identify the client as Alleged Maltreater.
Category/Module: Support
Root cause: In this particular case, Two actors IDs are there, so  we have an issue.
Fix provided: DB queries to update  record in actor  and intakeservicerequestactor table.
Data/Code fix ticket#: CDM-44115
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
delete from routing where insertedby = 'CDM-44115';
delete from placementrevision where insertedby = 'CDM-44115';
delete from livingarrangement where placementid = (select placementid from placement where insertedby = 'CDM-44115');
delete from placement where insertedby = 'CDM-44115';
*/
--intakeservicerequestactor
update intakeservicerequestactor
set actorid = '4d6a00c2-a632-4e23-a4cf-3273e4652533', updatedby ='CDM-44115', updatedon = now()
where intakeservicerequestactorid = 'bc86bbd7-f7f0-4b5f-9e23-655778eddb72' and activeflag = 1;
--actor
update actor 
set updatedon = now(), activeflag = 0, updatedby ='CDM-44115'
where actorid  = 'a4acefb8-4700-4344-85be-5cf2e9416513' and activeflag = 1;
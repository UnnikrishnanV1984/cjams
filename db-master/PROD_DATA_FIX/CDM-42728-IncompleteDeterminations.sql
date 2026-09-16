/*
Issue Description:
1. CLIENT ID - 2993700 - GAP Initial data for this client showing past GAP info(like Provider ID, dates etc)
2. CLIENT ID - 1648674 - CASE NUMBER - 3163777 (Wrongly showing on the IV-E Screen)
Category/Module: Bug
Root cause:
1. Investigation: Child Removal has no new record for Avis Isaa (the new guardian) in the active service case
2. Permanency plan had incorrect values, probably from data error
Fix provided: 
1. QA/BA analysis and user input is needed on missing Child Removal records
2. DB queries to rectify incorrect values
Data/Code fix ticket#: CDM-42728
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating permanencyplan 
update permanencyplan
set intakeservicerequestactorid = '5af9aa89-eda4-4430-b1aa-aea9cf24a895', updatedby = 'CDM-42728', updatedon = now()
where permanencyplanid = 'c19dc110-0d2c-424b-8a7e-8dd1738288b0' and activeflag = 1;
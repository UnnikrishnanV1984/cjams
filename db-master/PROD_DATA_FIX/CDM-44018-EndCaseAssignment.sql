/*
Issue Description: Please do a data fix to end date the following administrative assignments
Category/Module: Support Ticket
Root cause: Open assignments cannot be end-dated for closed cases
Fix provided: DB queries to end-date assignments for the closed cases
Data/Code fix ticket#: CDM-44018
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support Ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating caseassignment
--241022547355 
update caseassignment 
set enddate = '2024-09-13 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid in ('f6f6ee6a-8d2e-4878-b2d2-42b908859dfb', '01ed696b-43b4-49e0-bf4f-fbd43069f745') and activeflag = 1;
--231021259586 
update caseassignment 
set enddate = '2023-12-06 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid = '5d86e938-1f78-4817-bd98-77abb862ec28' and activeflag = 1;
--231021078288 
update caseassignment 
set enddate = '2023-10-23 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid = '806a3271-a695-401d-aea4-b7e8eb8d1f1d' and activeflag = 1;
--231020603728 
update caseassignment 
set enddate = '2023-08-29 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid in ('e650114c-6316-4da0-9a2d-75369c8f7d19', 'b60d0ea9-18fd-4105-8ac8-794357940a3f') and activeflag = 1;
--231020459570 
update caseassignment 
set enddate = '2023-04-28 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid = '72dea489-d278-443c-b811-2c5db83607dd' and activeflag = 1;
--231020484044 
update caseassignment 
set enddate = '2023-06-13 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid = 'd05a1be3-eb01-41f6-8217-b855f6ce7a8a' and activeflag = 1;
--231020425675
update caseassignment 
set enddate = '2023-04-10 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid = '9afb02b3-cb50-4216-bd5f-72e7dae1fdcf' and activeflag = 1;
--221020228402
update caseassignment 
set enddate = '2022-10-20 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid = '91e55977-efa6-4e01-ac09-0076c15c3a01' and activeflag = 1;
--221020230719
update caseassignment 
set enddate = '2022-07-26 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid = '43521460-9345-4faf-8b28-799817f083f5' and activeflag = 1;
--221020219767
update caseassignment 
set enddate = '2022-07-05 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid = '884f22b0-18ad-4431-9349-7c8013b24def' and activeflag = 1;
--221020217393
update caseassignment 
set enddate = '2022-06-30 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid = 'c4d13428-e83f-46b4-857d-e791e3260e33' and activeflag = 1;
--221020188412
update caseassignment 
set enddate = '2022-04-27 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid = '29861762-de96-4624-a700-861339b40c44' and activeflag = 1;
--211020165677
update caseassignment 
set enddate = '2022-01-24 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid = 'af16394d-8641-4048-bf45-72cd8a206ad4' and activeflag = 1;
--211020159452
update caseassignment 
set enddate = '2022-01-30 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid = '4fd1ed8b-af5f-4681-9090-361214f2148a' and activeflag = 1;
--211020130153
update caseassignment 
set enddate = '2021-11-19 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid = '6026d7b4-95ff-474e-9b78-48d427de14fc' and activeflag = 1;
--211020127091
update caseassignment 
set enddate = '2021-10-08 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid = '15cc4067-4a6b-42e3-8f7b-ae307eba4950' and activeflag = 1;
--202101320109006
update caseassignment 
set enddate = '2021-07-28 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid = 'd6539b29-9e37-4d18-a31c-69e0530c88f8' and activeflag = 1;
--2021083094845
update caseassignment 
set enddate = '2021-05-18 00:00:00.000', updatedby = 'CDM-44018', updatedon = now()
where caseassignmentid = '78e82b33-a06d-4f1c-b5ff-dada57ac9dc5' and activeflag = 1;
/*
Issue Description: Need fix to update the correct case no# 241030273941 for the OOH program for all the clients in the case.
Category/Module: Data Error
Root cause: OOH Program was updated with the incorrect Case due to data glitch
Fix provided: DB queries to approve the IV-E request and fix a previous PR
Data/Code fix ticket#: CDM-42809
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating personprogramarea
update personprogramarea
set objectid = '2ee478f0-2ab1-4b34-9e09-c03871371652', entityid = 241030273941, updatedby = 'CDM-42809', updatedon = now()
where activeflag = 1 and personprogramid in (
'08d1a799-dc90-4979-bd4a-b233e8abe467',
'53a54b2b-8096-47a2-aaef-2be8e96a2143',
'5a3e24dc-0386-4306-a5e4-90416c310618',
'd41de3e3-06a1-44ca-b09d-df9b7d4755a6',
'ead45299-a900-4e7a-b439-85854abdffd7');

--Updating tb_client_eligibility
update tb_client_eligibility
set case_id = 241030273941, update_user_id = 'CDM-42809', update_ts = now()
where eligibility_id in (10078027, 10078030, 10078029, 10078028, 10078031);

--Fixing PR from another ticket
update ivecaseclosurereview
set activeflag = 1, updatedby = 'CDM-42809', updatedon = now()
where ivecaseclosurereviewid = 'a4b8cb09-8aaa-4ff1-ae96-ac3daab66f1a' and activeflag = 0;
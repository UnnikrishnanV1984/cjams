/*
Issue:Unable to correct child's middle name in adoption case. Should be Lane Screen 
Root Cause:User request to change the middle name ,due to user do not acces do that.
Fix Provided (Data Fix Only):Data fix was done by Updated person table.
Data/Code fix ticket#: CJAMS-62350
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: user Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update person 
set substanceclasses = '["BTN"]',updatedby='CJAMS-62350', updatedon =now()
where personid in ('6c8dd4d1-2418-4a22-8189-cd2613faa0a2','90f52ccf-e70d-463c-bb74-35ec5a88232e')
and activeflag=1;

update person 
set substanceclasses = '["BENZO","BMTD"]',updatedby='CJAMS-62350', updatedon =now()
where personid in ('b309a12f-b2bc-4356-be6a-67430efb0da1','049450ff-3a43-4f75-8b8c-e0c2e808c748')
and activeflag=1;

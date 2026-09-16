
/*
Issue:Need SSA/Product Owner to review and approve removal of Zy'Eria Tomika Mason (CJAMSPID# 203029589) from Intake# I251013274791
Root Cause:The wrong person was added to the case because the system matched the entered SSN to a different existing profile due to incorrect CIS mapping.
Fix Provided (Data Fix Only):Updated actor,intakeservicerequestactor tables and deactiveted records.
Data/Code fix ticket#: CJAMS-59368
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This was not a system logic or coding but a data entry /mapping error due to incorrect SSN assocition.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update actor 
set activeflag =0,updatedby = 'CJAMS-59368', updatedon = now()
where actorid = '4418d416-99bf-4ddf-8f99-760a0e480d80' and activeflag =1;

update intakeservicerequestactor 
set activeflag = 0, updatedby = 'CJAMS-59368', updatedon = now()
where intakeservicerequestactorid in ('b9c1e5f3-7121-4c6f-8c7b-3adeed1d35b9','86d35efc-9370-475c-a358-cee329f9d6c5') and activeflag =1;

update personrole 
set activeflag = 0, updatedby = 'CJAMS-59368', updatedon = now()
where personroleid = 'faad283c-0bae-4b7c-b83c-9a820e0b1cb4' and activeflag = 1;


update personprogramarea
set activeflag = 0, updatedby = 'CJAMS-59368', updatedon = now()
where personprogramid  ='021cf338-0df3-4419-b8a6-ca500c1b5420' and activeflag = 1;

update  personroletype p
 set activeflag = 0, updatedby = 'CJAMS-59368', updatedon = now()
where personroleid = 'faad283c-0bae-4b7c-b83c-9a820e0b1cb4' and activeflag = 1;

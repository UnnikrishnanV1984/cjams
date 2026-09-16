/*
Issue: CJAMS-64251 Incorrectly created new person
Category/Module: Persons / Intake
Root cause: Intake # I251013457352 is connected to Service Case # 251030599655, and the intake worker created a new person profile (PID# 204312369) rather than selecting the existing client ID # 1273331.
            Data fix needed to remove the Client ID# 204476585 from the Intake# I251013625568 & Service Case# 251030599655, and add the Client ID # 204005403 to the intake.
Fix provided:  Data fix has been done to remove the incorrect person from the intake and case and add the correct person to the intake.
Incorrect Id: 204476585/ Correct Id: 204005401
Incorrect Id: 204476620/ Correct Id: 204005403
Data/Code fix ticket#: CJAMS-64251
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:User error. 
*/


update intakeservicerequestactor
set personid = 'dc3fa8db-4e85-4af5-a19d-10dded81535d',
    updatedby = 'CJAMS-64251',
    updatedon = now()
where intakenumber = 'I251013625568'
and personid = 'e72087dd-c891-42ac-9e15-099cc4fd43ed'
and activeflag = 1;


update intakeservicerequestactor
set activeflag = 0,
    updatedby = 'CJAMS-64251',
    updatedon = now()
where intakeserviceid = '9acb833e-3850-4557-a5a0-7b66e27116d6'
and personid = 'e72087dd-c891-42ac-9e15-099cc4fd43ed'
and activeflag = 1;

update intakeservicerequestactor
set personid = '38fef6ae-4156-453b-a6ea-7380cf787e1d',
    updatedby = 'CJAMS-64251',
    updatedon = now()
where intakenumber = 'I251013625568'
and personid = 'b796a2d7-1d39-4b0e-92e9-305efb305b47'
and activeflag = 1;


update intakeservicerequestactor
set activeflag = 0,
    updatedby = 'CJAMS-64251',
    updatedon = now()
where intakeserviceid = '9acb833e-3850-4557-a5a0-7b66e27116d6'
and personid = 'b796a2d7-1d39-4b0e-92e9-305efb305b47'
and activeflag = 1;


update actor
set personid = 'dc3fa8db-4e85-4af5-a19d-10dded81535d',
    updatedby = 'CJAMS-64251',
    updatedon = now()
where actorid in ('c3677c02-9606-49d7-b33b-702b2a990610','426b7774-9bd9-486a-8faa-08cae675431b')    
and personid = 'e72087dd-c891-42ac-9e15-099cc4fd43ed'
and activeflag =1;



update actor
set personid = '38fef6ae-4156-453b-a6ea-7380cf787e1d',
    updatedby = 'CJAMS-64251',
    updatedon = now()
where actorid in ('3ffa5725-6e69-4855-a6f1-7d9bccd696f2','0e70cb87-6fc8-48e7-9466-a45413f1c194')
and personid = 'b796a2d7-1d39-4b0e-92e9-305efb305b47'
and activeflag =1;


update personrole
set personid = '38fef6ae-4156-453b-a6ea-7380cf787e1d',
    updatedby = 'CJAMS-64251',
    updatedon = now()
where personroleid = '32af4e59-9374-4587-bec4-7a0d870bacb9'
and activeflag = 1;

update personrole
set activeflag = 0,
    updatedby = 'CJAMS-64251',
    updatedon = now()
where personroleid = 'cf82cf4e-661f-4482-9df7-af3b117118b1'
and activeflag = 1;


update personrole
set personid = 'dc3fa8db-4e85-4af5-a19d-10dded81535d',
    updatedby = 'CJAMS-64251',
    updatedon = now()
where personroleid = '01e3a293-6479-4f8e-a3ac-91e500968112'
and activeflag = 1;

update personrole
set activeflag = 0,
    updatedby = 'CJAMS-64251',
    updatedon = now()
where personroleid = 'e2b2d4f3-8fa6-47be-81f8-585dc5680046'
and activeflag = 1;
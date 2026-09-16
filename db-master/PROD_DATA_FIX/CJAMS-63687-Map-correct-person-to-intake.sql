/*
Issue: CJAMS-63687 Incorrectly created new person
Category/Module: Persons / Intake
Root cause: Intake # I251013457352 is connected to Service Case # 251030599655, and the intake worker created a new person profile (PID# 204312369) rather than selecting the existing client ID # 1273331.
            Data fix needed to remove the Client ID# 204312369 from the Intake# I251013457352 & Service Case# 251030599655, and add the Client ID # 1273331 to the intake.
Fix provided:  Data fix has been done to remove the Client ID# 204312369 from the Intake# I251013457352 & Service Case# 251030599655, and add the Client ID # 1273331 to the intake.
Data/Code fix ticket#: CJAMS-63687
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:User error. 
*/

update intakeservicerequestactor
set personid = '0bb48e1b-56cb-462e-818b-f938eb2aef85',
    updatedby = 'CJAMS-63687',
    updatedon =now()
where personid in ('757dc638-7360-4a07-829d-11c6cabfbe99')
and intakeserviceid = '8e8df111-d8c0-498b-9b19-cf0ba185b142'
and activeflag = 1;

update intakeservicerequestactor
set personid = '0bb48e1b-56cb-462e-818b-f938eb2aef85',
    updatedby = 'CJAMS-63687',
    updatedon =now()
where personid in ('757dc638-7360-4a07-829d-11c6cabfbe99')
and intakenumber = 'I251013457352'
and activeflag = 1;

update intakeservicerequestactor
set activeflag = 0,
    updatedby = 'CJAMS-63687',
    updatedon =now()
where personid in ('757dc638-7360-4a07-829d-11c6cabfbe99')
and servicecaseid = '8447d77b-5fbc-4ab3-af98-a05c9dbe54a9'
and activeflag = 1;




update actor
set personid = '0bb48e1b-56cb-462e-818b-f938eb2aef85',
    updatedby = 'CJAMS-63687',
    updatedon =now()
where personid in ('757dc638-7360-4a07-829d-11c6cabfbe99')
and actorid in ('c38c6b06-7f83-4305-8977-60ba681f94d0','036d82d4-16c3-482e-aada-398b886ca8a8')
and activeflag = 1;

update actor
set activeflag = 0,
    updatedby = 'CJAMS-63687',
    updatedon =now()
where personid in ('757dc638-7360-4a07-829d-11c6cabfbe99')
and actorid in ('0121addf-1b32-40e1-b924-a9e88569b5eb')
and activeflag = 1;


update personrole
set personid = '0bb48e1b-56cb-462e-818b-f938eb2aef85',
    updatedby = 'CJAMS-63687',
    updatedon =now()
where personid in ('757dc638-7360-4a07-829d-11c6cabfbe99')
and intakeserviceid = '8e8df111-d8c0-498b-9b19-cf0ba185b142'
and activeflag = 1;

update personrole
set activeflag = 0,
    updatedby = 'CJAMS-63687',
    updatedon =now()
where personid in ('757dc638-7360-4a07-829d-11c6cabfbe99')
and personroleid in ('87ac72db-10c7-4b64-b4ce-57b18e45fb75','f1e6d5c5-c80e-40af-afc9-ff65a02f4acc')
and activeflag = 1;

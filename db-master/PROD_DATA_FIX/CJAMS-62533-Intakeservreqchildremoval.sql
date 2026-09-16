/*
Issue:211030012115:Youth's child removal date was 7/8/25 due to emancipation from care. However she continues to show up reports even after child removal was completed months ago.
Root Cause:Duplicate draft removal record was created due to a data anomaly, requiring a datafix to deactivate it.
Fix Provided (Data Fix Only):Data fix was done by Updated intakeservreqchildremoval table.
Data/Code fix ticket#: CJAMS-62533
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update intakeservreqchildremoval
set activeflag  = 0, updatedby  ='CJAMS-62533', updatedon=now()
where intakeservreqchildremovalid  ='211e380b-b55e-4fb0-ab79-8a19e6d6978f' and activeflag  =1;

update intakeservreqchildremoval_history 
set activeflag  = 0, updatedby  ='CJAMS-62533', updatedon=now()
where intakeservreqchildremovalhistoryid  ='d8fa4381-5485-440f-b34b-d586d67731eb' and activeflag  =1;



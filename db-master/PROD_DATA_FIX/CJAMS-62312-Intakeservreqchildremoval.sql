/*
Issue:This showed up in my pending review screen yesterday. It's from 2015.The respective case CW9593778 is available under the user pending dashboard.
Root Cause:Duplicate draft removal record was created due to a data anomaly, requiring a datafix to deactivate it.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table  routing table..
Data/Code fix ticket#: CJAMS-62312
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update intakeservreqchildremoval 
set  activeflag=0 ,updatedon = now(),updatedby  = 'CJAMS-62312'
where  intakeservreqchildremovalid='8fd76b3a-d507-476e-bd78-20923b87b157' and activeflag =1;

update intakeservreqchildremoval_history
set  activeflag=0 ,updatedon = now(),updatedby  = 'CJAMS-62312'
where  intakeservreqchildremovalid='8fd76b3a-d507-476e-bd78-20923b87b157' and activeflag =1;
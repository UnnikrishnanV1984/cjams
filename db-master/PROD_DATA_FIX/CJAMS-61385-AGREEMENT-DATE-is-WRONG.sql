/*
Issue:Data fix needed for Agreement start date to be changed to 03/24/22 as per the custody and guardian ship 
Root Cause:User requested to updates start and end dates due to they do not have access to delete.
Fix Provided (Data Fix Only):Data fix was done by Updated gapagreement,gapagreementrevision table .
Data/Code fix ticket#: CJAMS-61385
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update gapagreement 
set startdate = '2022-03-24 00:00:00.000',enddate = '2028-06-16 00:00:00.000', updatedby = 'CJAMS-61385', updatedon = now()
where gapagreementid ='fa5e2798-1f67-4c17-b453-ca9f6ed51c71' and activeflag =1;


update gapagreementrevision 
set startdate = '2024-03-24 00:00:00.000',enddate = '2028-06-16 00:00:00.000', updatedby = 'CJAMS-61385', updatedon = now(),approvaldate =now()
where gapagreementrevisionid  in ('1d625cb5-0951-444b-9591-b1462f1050ff','0c5e9265-5689-4078-a671-33d8fb42d302') and activeflag =1;

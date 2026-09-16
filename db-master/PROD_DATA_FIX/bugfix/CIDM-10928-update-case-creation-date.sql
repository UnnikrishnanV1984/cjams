/*
   Issue Description: CIDM-10928 AR/IR start date/time pulling from wrong referral narrative
   Category/ Module  :  CPS IR Case creation
   Root cause: AR/IR start date/time pulling from wrong referral narrative information due to the code merge issues done as the part of Form1080 changes CIDM-10473.
   Fix Provided: Data fix has been done to update the case creation date to the that of Addendum date.  
   Data/ Code fix ticket#:CIDM-10928
   Regression Impacts: N/A
   Is Code fix Required?: yes
   Code fix ticket#: CDM-44592
   Reason why no related code fix: N/A 
*/


update intakeservicerequest
set reporteddate = '2025-11-13 12:51:00',
    updatedby = 'CIDM-10928',
    updatedon = now()
where intakenumber = 'I251013414544' and activeflag =1;
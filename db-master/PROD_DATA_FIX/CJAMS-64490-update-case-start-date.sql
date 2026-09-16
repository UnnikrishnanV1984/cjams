/*
Issue: CJAMS-64490 Response Timer
Category/Module: Case / start date
Root cause: This issue was resolved as the part of CDM-44592 AR/IR start date/time pulling from wrong referral narrative
             and deployed in the prod on Dec 17 2025
            User has added the addendum before this Code fix moved to prod
Fix provided:  Data fix has been done to correct case start date as 12/15/2025 4:13 PM and response timer 12/20/2026 4:13 PM
Data/Code fix ticket#: CJAMS-64490
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CDM-44592
Reason why no related code fix: N/A
*/


update intakeservicerequest
set reporteddate = '2025-12-15 16:13:00',
    updatedby = 'CJAMS-64490',
    updatedon = now()
where intakeserviceid = '678cfb39-fa85-49b7-8ac6-54ed51ba9bef' and activeflag =1;

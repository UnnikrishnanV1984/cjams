/*
Issue Description: CJAMS-63596
Category/Module: GAP Rate can't be approved
Root cause: User requested to data fix to change the end date of the review subsidy rate record to 10/31/2025 and 
change to approved status
Fix provided: D Data fix has been promoted to change the end date of the review subsidy rate record to 10/31/2025 and 
change to approved status
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/

update gapagreementrate 
  set enddate= '2025-10-31 00:00:00.000',
      updatedby = 'CJAMS-63596', 
      updatedon = now() 
where  gapagreementrateid = '133cd2ec-0488-4c25-8228-ec4acb77964c' 
and activeflag = 1;

update gapratesrevision
set rateenddate = '2025-10-31 00:00:00.000',
    approvaldate = now(),
    approvalstatustypekey = 3047,
    updatedon = now(),
    updatedby = 'CJAMS-63596'
where gapratesrevisionid = '7bae9f2b-6d78-48bf-b406-5fd4242acf6c'
and activeflag =1;
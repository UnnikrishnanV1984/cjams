
/*
 Issue Description: CDM-44061
-- Category/ Module: Child Removal
-- Root cause: User requested to udpate child removal end date and person program end date.
-- Fix Provided: Datafix has been promoted to update end date.
-- Pull request# N/A
-- Reason why no related code fix: User Error
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update intakeservreqchildremoval 
set exitdate = null, updatedon = now(),updatedby = 'CDM-44061'
where intakeservreqchildremovalid = 'eebd8bb7-0c8f-4a91-acb5-5c99652e5666' and activeflag = 1;

update personprogramarea
set enddate =null, updatedon = now(),updatedby = 'CDM-44061'
where personprogramid = '277626da-35af-4a8e-b29b-6b4b6e9ddeeb' and activeflag = 1;

update tb_client_eligibility 
set end_dt =null, update_user_id = 'CDM-44061', update_ts = now()  
where removal_id =308011;
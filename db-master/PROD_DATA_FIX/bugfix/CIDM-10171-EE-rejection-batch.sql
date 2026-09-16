/*
   Issue Description: Title IV-E Foster Care Client Eligibility table has Start date as NULL, we need this data fix for preventing the ENE Outbound Batch Job
   Category/ Module  : Title-IVE 
   Root cause: Records are inserting in tb_client_eligibility before updating the removaldate column in "intakeservreqchildremoval"
   Fix Provided: Data fix to update the start date as child removal date
   Data/Code fix ticket#: CIDM-10171
   Regression Impacts: Title IVE Foster care Determination flow
   Is Code fix Required?: No
   Status of the code fix if already submitted and expected prod fix date: N/A  
*/


update tb_client_eligibility ce
    set start_dt = (select rm.removaldate::date from intakeservreqchildremoval rm where rm.removalid = ce.removal_id),
    end_dt = (select rm.exitdate::date from intakeservreqchildremoval rm where rm.removalid = ce.removal_id),
    update_ts = now(),
    update_user_id = 'CIDM-10171'
where ce.delete_sw  = 'N'
and btrim(ce.eligibility_type_cd) = '2931'
and ce.start_dt is null
and (select count(*) from intakeservreqchildremoval rm where rm.removalid = ce.removal_id and rm.removaldate is not null) > 0 ;
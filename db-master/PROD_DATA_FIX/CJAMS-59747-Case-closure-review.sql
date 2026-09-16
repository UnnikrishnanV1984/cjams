/*
Issue Description:CJAMS-59747 3232416:The case for Peyton Mccullough 200896166 has been submitted for the case closure review by the worker but it is not appearing on my dashboard to assign.
Category/Module: Title IV-E
Root cause: Data Migration issue and incorrect caseid is assigned to the person 200896166 in tb_client_eligibility table.
            Proc changes were added as the part of CDM-42867 Missing cases on the case closure dashboard to pull the cases
            based on the case_id and this was making the case not to show up in the dashboard
Fix provided: Data fix is also needed as the part of this ticket to update the removalid in the tb_client_eligibility table.
Data/Code fix ticket#: CJAMS-59747
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue
*/

update tb_client_eligibility
set case_id = '3232416',
    update_user_id = 'CJAMS-59747',
    update_ts = now()
where client_id = 200896166
and delete_sw = 'N';
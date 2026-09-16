/*
Issue Description:CJAMS-63747 Placement Issues
Category/Module: Child removal
Root cause: As per system design, the Provider Placement can not be exited if the child placement exit date is overlapping with the Adoption agreement start date.
            Use has updated the placement end date and data fix needs to be done to change the child removal and program assignment end date.
            Client ID: 200978997 (Zyon Green)
            Provider ID: 6038102 (Keesha Howard)
            Adoption Agreement Start Date: 11/22/2025
            Placement Exit Date: 11/25/2025
            Child Removal End Date: 11/25/2025
Fix provided: Data fix has been done to update the Child removal end date from 11/25/2025 to 11/22/2025 and also the OOH program assignment end date from 11/25/2025 to 11/22/2025
Data/Code fix ticket#: CJAMS-63747
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is as per the system design and data fix should resolve the issue. 
*/


update intakeservreqchildremoval 
set exitdate = '2025-11-22 11:29:00',
	returntransts = '2025-11-22',
	returntime = '2025-11-22 11:29:00',
	updatedby = 'CJAMS-63747',
    updatedon = now()
where intakeservreqchildremovalid='66e9f548-1e7e-4c71-9a21-fa7f9e8d4771'
and activeflag =1;


update personprogramarea 
set enddate = '2025-11-22 00:00:00', 
updatedby ='CJAMS-63747', 
updatedon = now()  
where personprogramid ='b8cde525-16fb-4cd0-9ec1-8ac5822ad51f' 
and activeflag = 1;

update tb_client_eligibility
set end_dt = '2025-11-22 00:00:00',
    update_user_id = 'CJAMS-63747',
    update_ts = now()
where removal_id = 259346
and delete_sw = 'N';
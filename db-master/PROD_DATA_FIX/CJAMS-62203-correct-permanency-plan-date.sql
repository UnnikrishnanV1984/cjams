/*
Root cause: 3249566:This child's removal has been end dated. We need the end date to be removed so that we can enter the Kin as a paid kin and them we can end date the removal again.
            This is not a defect. As per the system design, the child removal will automatically end when the Living Arrangement/Provider Placement is ended with exit type is selected as 'Permanently Leaving Custody & Care'.
            Data fix is needed to change the permanency plan established date to 02/28/2024.
Fix provided: Data fix has been done to update the dates for the permanency plan established date to 02/28/2024.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix needed to update the permanency plan details.
*/

update permanencyplan
set establisheddate = '2024-02-28 00:00:00.000',
    updatedby = 'CJAMS-62203',
    updatedon = now()
where permanencyplanid  = '67b05f61-62ff-4349-9135-65d82bc6212d'
and activeflag = 1;
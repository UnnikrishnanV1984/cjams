/*
   Issue Description: CDM-42213 Foster care and case number link is not showing up
   Category/ Module  : IV-E Foster care 
   Root cause: adopted child role was set to 'other child (Not in household)' in dropdown inspite of other radio button being active
    so the intakeservicerequestpersontypekey is getting as OTHCHNH leading the SP to return case number as NULL.
    The FC was getting null value because bioclientid was coming null as it was map with the null removal id.
    SP: 'sp_adoption_eligibility_worksheet_info'
   Fix provided : Data fix has been promoted to update the correct intakeservicerequestpersontypekey in intakeservicerequestactor table 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update intakeservicerequestactor
-- OTHCHNH
set intakeservicerequestpersontypekey = 'CHILD',
	updatedby = 'CDM-42213',
	updatedon =  now()
where intakeservicerequestactorid = 'c001c74f-0604-4035-8806-0717e0e4591f'
and activeflag = 1;
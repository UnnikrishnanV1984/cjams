/*
   Issue Description: CDM-39497
   Category/ Module  :Placement
   Root cause:The child, Brytin Lower PID#: 4399257 Living Arrangement for dates: 8/5/2022-9/12/2022 need to have the caregiver updated, as the system will not allow the changes to be made/saved.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update livingarrangement set primarycaregiver='BARBARA  SWEITZER',caregiverclientid='18dc7ae2-8490-4398-914e-c6078b1bd10d',secondarycaregiver=null,partnerid=null, updatedby = 'CDM-39497', updatedon = now() 
where personid='65f05624-cdfb-4960-8f66-585ab844339f' and placementid='e737623b-1762-4edf-955c-d062537fcb87' and activeflag = 1;

/*
   Issue Description: CDM-21267
   Category/ Module  :case connection
   Root cause: user wants to connect service case to intake  
   Pull request# for code fix: 5088
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservicerequestdispositioncode 
set intakeserreqstatustypeid  = 'c8dbf10f-843d-4b40-97ca-288d750463da', updatedby = 'CDM-21267', updatedon = now() 
where intakeserviceid = '40a55214-05fc-4544-80c4-b3f9034b7282';

update intakedastatus
set status = 2, updatedby = 'CDM-21267', updatedon = now() 
where intakenumber = 'I221010250673';

update intakeservicerequest
set actiontype = 'AR', intakeserreqstatustypeid = 'c8dbf10f-843d-4b40-97ca-288d750463da', intakeservicerequestclassid = 'b74ded78-12dc-4e6d-94db-7662d6eaf093', updatedby = 'CDM-21267', updatedon = now() 
where intakeserviceid = '40a55214-05fc-4544-80c4-b3f9034b7282';
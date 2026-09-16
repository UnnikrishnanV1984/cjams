
/*
   Issue Description: CJAMS-68668
   Category/ Module  : Decision
   Root cause:  Approval to update the Requested date and approved date

                Requested date-06/18/2026, 03:35 PM
                Approved date-06/18/2026, 04:21 PM
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update intakeservicerequestdispositioncode 
set insertedon ='2026-06-18 15:35:34.973',statusdate='2026-06-18 16:21:34.973',updatedon ='2026-06-18 16:21:34.973',updatedby ='CJAMS-68668' 
where intakeservicerequestdispositioncodeid ='18446027-fe0b-46a2-84b3-60b2b223139e' and activeflag = 1;


update routing 
set insertedon ='2026-06-18 16:21:34.973',updatedon ='2026-06-18 16:21:34.973',updatedby ='CJAMS-68668' 
where objectid ='18446027-fe0b-46a2-84b3-60b2b223139e' and routingstatustypeid  = '16' and activeflag = 1;
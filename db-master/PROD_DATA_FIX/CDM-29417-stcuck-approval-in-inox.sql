/*
   Issue Description: CDM-29434
   All cases and assessments under Case Pending Approval 
   and Assessment Pending Approval inbox have been approved. Need to remove all from user dashboard.
*/

update
    routing
set
    activeflag = 0,
    updatedby = 'CDM-29417',
    updatedon = now()
where
    routingid = 'fd157a28-b8f0-4325-8f24-ae8c095584ee';

/*
   Issue Description: CDM-29572-approvals
   Category/ Module  : CDM
   Pull request# for code fix: 
   Reason why no related code fix: User wants to remove case from dashboard
   Status of the code fix if already submitted and expected prod fix date: 

*/


 
update routing set activeflag = 0,updatedby = 'CDM-29572', updatedon = now()
where 
routingid
in ('17dff23f-28e8-4d22-a861-8ef04fc8f0a5','eb23d155-0b63-40ab-808d-1467a4956200','63d52f25-85fa-4572-bbc5-3d775c76caee');
 

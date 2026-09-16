/*
   Issue Description: CDM-18439
   Category/ Module  : Removing duplicate 
   Root cause: user requeseted to remove duplicate investigation finding
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update investigationallegation set activeflag = 0, updatedby = 'CDM-19224',updatedon = now() 
where investigationallegationid in ('842d286f-9c09-442e-bcc1-e911012f761f','d420bee6-c5f6-4d97-a677-6ad79ad99c47') 
and investigationid = '8b0e482a-14d7-4f35-b13e-32c1033e5d24' and activeflag = 1;
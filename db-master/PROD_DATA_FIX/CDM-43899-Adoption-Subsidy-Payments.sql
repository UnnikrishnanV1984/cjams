/*
   Issue Description: CDM-43899
   Category/ Module  :Subsidy rate end date.
   Root cause: user wants to change
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   
*/

update routing
set activeflag = 0, updatedby ='CDM-43899', updatedon = now()
where routingid ='0cf34a60-1354-41ed-bbe2-40139f304db4' and activeflag = 1;

update  adoptioncaserevision  
set activeflag = 0,updatedby ='CDM-43899',updatedon =now() 
where  adoptionagreementrateid ='82615b6d-ab09-4a43-b3db-55236b3bba13' and activeflag = 1;

update  adoptioncaseagreementrate  
set activeflag = 0,updatedby ='CDM-43899',updatedon =now() 
where  adoptionagreementrateid ='82615b6d-ab09-4a43-b3db-55236b3bba13' and activeflag = 1;


/*
  Issue Description: CDM-32983- Missing service case
  Root cause: Service case is not being populated 
  Fix Prrovided: Did data fix to create the servicecase 
*/

--updatedby is effecting supervisor name on the screen level 



select * from cjams.createservicecase('7da2e11b-846d-4f79-8b62-da83132ddc28','',1,'a0b41798-e864-415d-8647-1a44cb6c5bda','ASSGN','CDM-32983');

update cjams.routing set routingstatustypeid =2 
--, updatedby ='CDM-32983'
, updatedon = now()
where routingid ='20b56d63-7fc4-4b63-8fc4-98e2e47a8b19';


update cjams.servicecase set dispositioncode ='Open', statustypekey ='Open', updatedby ='CDM-32983'
where servicecaseid in (select servicecaseid from intakeservicerequest where intakeserviceid ='7da2e11b-846d-4f79-8b62-da83132ddc28');
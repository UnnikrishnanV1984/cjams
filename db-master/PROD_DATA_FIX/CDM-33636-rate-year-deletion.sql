/*
   Issue Description: CDM-33636
   Category/ Module  : agreement document
   Root cause: user requested to remove one rate
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/ 
update adoptioncaserevision set approvaldate =now(),activeflag = 0,updatedon =now(),updatedby = 'CDM-33636'  where adoptionagreementid  = 'b84e04dc-a1b7-4559-ab26-f49469c9ceb6' and adoptionagreementrateid  ='dfd40846-75ec-4e00-aa64-23398b2aa614'and adoptionrevisionid ='359d762e-f245-4aff-9038-7f1beb8c55e1';

update adoptioncaseagreementrate set activeflag = 0,updatedon =now(),updatedby = 'CDM-33636' where adoptionagreementrateid = 'dfd40846-75ec-4e00-aa64-23398b2aa614';

update routing set activeflag =0,updatedon =now(),updatedby = 'CDM-33636' where objectid  ='dfd40846-75ec-4e00-aa64-23398b2aa614' and routingid ='0b69d6ed-1241-4809-9403-93164cbd6b9b'
/*
   Issue Description: CDM-25955
   Category/ Module  : service log/ purchase auth
   Root cause: user wants to remove pending records from authorization list 
   Pull request# for code fix: 6642
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update cjams.routing set activeflag  =1, updatedby ='CDM-25955', updatedon =now()

where routingid ='01bc496f-827d-4621-81a3-1fa61286a28f';


delete from cjams.routing where routingid in('0a6f2e50-2740-4352-9b85-388e07710ac3','4c0e20bd-cfbd-4c3c-8403-e3cb8e6e3abb', 'e7c7bcdf-9a82-4d88-80d9-ed64b534c6c4');
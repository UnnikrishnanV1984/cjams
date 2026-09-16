/*
   Issue Description: CDM-33815
   Category/ Module  : service plan 
   Root cause: user requeseted to update  the service plan effective date from 07/18/2023 to 07/10/2023.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update serviceplan set effectivedate='2023-07-10 08:00:00.000',updatedby='CDM-33815',updatedon=now()
where serviceplanid ='1040a02c-f9d3-44f1-bdd6-08b557cee460';
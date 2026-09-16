/*
   Issue Description: CDM-32248
   Category/ Module  : Agreement Document
   Fix Provided: user requested to remove one record of suspension payment
   Pull request# for code fix: 
   Reason why no related code fix:
   Status of the code fix if already submitted and expected prod fix date: 

*/

update routing set activeflag = 0,updatedby ='CDM-32248',updatedon =now() where routingid in('c0406ce6-3919-4c6b-8b61-b691876a000d','98179429-ce5b-4e3b-af93-8ab351773095');

update adoptioncasesuspensionrevision  set approvaldate = now() ,updatedby ='CDM-32248',updatedon =now()
where adoptionsuspensionid = '9bfe3a64-d2a6-456d-8084-8f47a00a8ae3';
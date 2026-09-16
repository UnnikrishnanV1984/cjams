/*
   Issue Description: CDM-15390
   Category/ Module  : Approved service log still pending/Service log 
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE routing
SET activeflag = 1, updatedby = 'CDM-15390', updatedon = now() 
WHERE routingid = 'a812ba21-260f-482d-8ad2-e65f8e86dc2f';


delete from routing 
where 
routingid in ('398476f8-eeb1-470c-aedb-c30b26674746', '3e152276-5a72-452c-a5bd-1198431d2f83', 'af5223ad-53e7-42b5-b6f4-41b8cff49e63');
/*
   Issue Description: CDM-28462
   Category/ Module  :Inability to Close Adoption Case
   Root cause: :I am unable to close a child's adoption case as he still has an OHP assignment. He is about to be adopted again, however, I am unable to proceed with the ACA in the open OHP case as I am unable to close the adoption case. 
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/


-- update personprogramarea set enddate = '2021-01-08 00:00:00', updatedby = 'CDM-28462', updatedon = now() where personprogramid = '479b1843-2641-4563-bc0b-e3306d498faf';


update adoptioncase set statustypekey = 'Close', updatedby = 'CDM-28462', updatedon = now() where adoptioncaseid = '4dcad6e4-7631-47df-9821-219830e9fa63';


update adoptioncaseagreement set enddate = '2021-01-08 00:00:00', updatedby = 'CDM-28462', updatedon = now() where adoptioncaseid = '4dcad6e4-7631-47df-9821-219830e9fa63';

UPDATE caseassignment SET enddate = '2021-01-08 00:00:00', updatedby = 'CDM-28462', updatedon = now() WHERE caseassignmentid = 'cfcf3b9b-9d55-4fd5-991f-bf54b7da84d0';


update routing set insertedon ='2021-08-01 13:30', updatedby = 'CDM-28462', updatedon  ='2021-08-01 13:30',  fromsecurityusersid ='2f784d3d-00a5-4798-9f36-fb5e0cb8d68b' 
, tosecurityusersid ='e0dca1e3-fad0-48e8-befa-a5cca6a7d31d'  where routingid ='5e5f8b18-01c5-4e62-b5d5-bffa1790d71b'; 

update adoptioncasedisposition set  statusdate ='2021-08-01 13:00',intakeserreqstatustypekey ='Closed',
dispositioncode ='Closed', updatedby = 'CDM-28462', updatedon = now(), insertedby ='e0dca1e3-fad0-48e8-befa-a5cca6a7d31d'   where adoptioncasedispositionid ='22f112f8-cfeb-4250-9fa1-e0a222f05818';



/*
   Issue Description: CDM-21203
   Category/ Module  : case approval
   Root cause: user asked to remove
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update permanencyplan set enddate = '2022-03-09 00:00:00',updatedon = now(), updatedby = 'CDM-21203' where permanencyplanid = 'd3c3404e-d4f8-48ba-8085-0601c7f194c4';
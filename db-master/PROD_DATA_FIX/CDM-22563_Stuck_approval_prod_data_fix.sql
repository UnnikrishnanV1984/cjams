/*
   Issue Description: CDM-22563
   Category/ Module  : stuck approval removal
   Root cause: stuck approval removal
   Pull request# for code fix: 
   
*/

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-22563' 
where routingid = '713b6d29-8750-4aab-8859-50f86aeaedb2';
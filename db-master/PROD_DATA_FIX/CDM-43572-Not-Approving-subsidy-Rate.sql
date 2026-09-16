/*
  Issue Description: CDM-43572
  Root cause: User request 
  Fix Prrovided: Did data fix to show the review request in correct supervisor approval. inbox.
*/


update routing
set toroleid='CWSP', tosecurityusersid='aabfe50d-3996-444c-a2fb-4640f0ff257b', updatedby='CDM-43572', updatedon = now()
where objectid='9ae59a48-c616-4b94-ace7-5d605cccb7b7' and activeflag = 1;


update routing
set toroleid='CWSP', tosecurityusersid='aabfe50d-3996-444c-a2fb-4640f0ff257b', updatedby='CDM-43572', updatedon = now()
where objectid='1e07123b-19b0-4c6b-a5d6-64744cc9bc86' and activeflag = 1;
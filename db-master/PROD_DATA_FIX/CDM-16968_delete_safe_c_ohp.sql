/*
   Issue Description: CDM-16968
   Category/ Module  :  Delete Safe-c OHP
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

update assessment set activeflag = 0, updatedon = now(), updatedby = 'CDM-16968' where servicecaseid = '045fde9b-165e-499a-a69d-b0282e0ff1e9'
and assessmenttemplateid = 'f6e4c466-72ae-4453-9997-a2a12fcf8035'
and submissionid  = '6143691d19ac88001a0d4eea'
and assessmentid = '6400780a-fcea-4ff7-97e9-6770022707df';
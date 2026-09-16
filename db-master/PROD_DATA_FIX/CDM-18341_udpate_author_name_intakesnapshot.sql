/*
   Issue Description: CDM-18341
   Category/ Module  : Contact details user informatoin 
   Root cause: 
   Pull request# for code fix: 4345
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- select jsondata from intakesnapshot WHERE intakenumber = 'I211010209679' and intakesnapshotid = '658b71ea-3483-4e16-8ca1-25618777ed2f' AND activeflag=1;
UPDATE intakesnapshot 
set  jsondata = (jsonb_set(jsondata, '{General, Author}', '"VanessaBlackwell"') ::jsonb), updatedby = 'CDM-18341', updatedon = now() 
WHERE intakenumber = 'I211010209679' and intakesnapshotid = '658b71ea-3483-4e16-8ca1-25618777ed2f' AND activeflag=1;
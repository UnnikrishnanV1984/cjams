/*
   Issue Description: CDM-33153
   Category/ Module  : intake won't approve
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakedastaging 
SET jsondata = jsonb_set(jsondata::jsonb, '{General,countyid}', concat('"','b26afb64-6b7f-462e-8074-cfdc9cce04c4','"')::jsonb, true)
where intakenumber = 'I231010830722'::character varying and activeflag = 1;	
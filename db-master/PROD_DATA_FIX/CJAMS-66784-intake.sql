/*
   Issue Description: CJAMS-66784
   Category/ Module  : Intake
   Root cause: user requested to change jurisdiction from Talbot to caroline county
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/


update intakedastaging 
set jsondata = replace (jsondata::text,  '"countyid": "cd1940bd-e41d-4d9f-8f73-936fdf05a2cf"', '"countyid": "9f60d4f1-4004-474f-a432-a19da7b1efe0"' )::jsonb,
    updatedby = 'CJAMS-66784', 
    updatedon = now()
where intakenumber = 'I261013986320' and activeflag = 1;
/*
   Issue Description: CDM-33350
   Category/ Module  : Intake
   Root cause: user requested to change jurisdiction from Baltimore county to Baltimore City
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/


update intakedastaging 
set jsondata = replace (jsondata::text,  '"countyid": "1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b"', '"countyid": "7665ca54-5374-4174-be07-a687b811a82c"' )::jsonb,
    updatedby = 'CDM-33350', 
    updatedon = now()
where intakenumber = 'I231010593022' and activeflag = 1;
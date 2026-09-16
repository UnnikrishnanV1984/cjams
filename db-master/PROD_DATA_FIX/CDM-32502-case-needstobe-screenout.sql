/*
   Issue Description: CDM-32502
   Category/Module : Intake
   Root cause:unable to screenout intake
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 


update routing set activeflag = 1, eventcode ='INTR',updatedby ='CDM-32502',updatedon =now() where routingid= '1d55e3ef-7781-4f71-bf2f-1a9226a84b3c';

--change county from Baltimore County to Baltimore city
update intakedastaging 
set jsondata = replace (jsondata::text,  '"countyid": "1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b"', '"countyid": "7665ca54-5374-4174-be07-a687b811a82c"' )::jsonb,
    updatedby = 'CDM-32502', 
    updatedon = now()
where intakenumber = 'I221010312524' and activeflag = 1;
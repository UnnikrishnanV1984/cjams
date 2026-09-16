/*
   Issue Description: CDM-33077
   Category/Module : Intake
   Root cause:user unable to screenout intake due to county wrong update
   Fix Provided: Did data fix to update the correct county 
*/ 


update intakedastaging 
set jsondata = replace (jsondata::text,  '"countyid": "f5214cb2-953e-41a9-a4ad-71341501e2ad"', '"countyid": "7665ca54-5374-4174-be07-a687b811a82c"' )::jsonb,
    updatedby = 'CDM-33077', 
    updatedon = now()
where intakenumber = 'I231010792784' and activeflag = 1;
/*
   Issue Description: CDM-33077
   Category/Module : Intake
   Root cause:user unable to screenout intake due to wrong county name
   Fix Provided: Did data fix to update the correct county 
*/ 


update intakedastaging 
set jsondata = replace (jsondata::text,  '"countyid": "c81be790-a79d-40ac-a38d-abd4dd5a81f6"', '"countyid": "f6ab02d5-c386-4659-8810-687fc191a967"' )::jsonb,
    updatedby = 'CDM-34972', 
    updatedon = now()
where intakenumber = 'I231010637492' and activeflag = 1;
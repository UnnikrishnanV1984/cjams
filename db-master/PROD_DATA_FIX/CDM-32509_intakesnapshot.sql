/*
   Issue Description: CDM-32509
   Category/Module : Intake
   Root cause:unable to screenout intake
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/ 

UPDATE intakesnapshot 
SET 
    updatedby = 'CDM-32509', 
    updatedon = now(), 
    jsondata = replace(jsondata ::text , '"supDisposition": "Scrnin"', '"supDisposition": "ScreenOUT"')::jsonb
WHERE intakenumber = 'I231010679673' AND activeflag=1;

UPDATE intakedastaging 
SET 
    updatedby = 'CDM-32509', 
    updatedon = now(), 
    jsondata = replace(jsondata ::text , '"supDisposition": "Scrnin"', '"supDisposition": "ScreenOUT"')::jsonb
WHERE intakenumber = 'I231010679673' AND activeflag=1;

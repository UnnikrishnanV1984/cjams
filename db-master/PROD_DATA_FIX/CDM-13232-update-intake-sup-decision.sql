UPDATE intakesnapshot 
SET 
    updatedby = 'CDM-13232', 
    updatedon = now(), 
    jsondata = replace(jsondata ::text , '"supDisposition": ""', '"supDisposition": "Scrnin"')::jsonb
WHERE intakenumber = 'I202100554922' AND activeflag=1;

UPDATE intakedastaging 
SET 
    updatedby = 'CDM-13232', 
    updatedon = now(), 
    jsondata = replace(jsondata ::text , '"supDisposition": ""', '"supDisposition": "Scrnin"')::jsonb
WHERE intakenumber = 'I202100554922' AND activeflag=1;

update IntakeDAStatus
SET 
    status = 2,
    updatedby = 'CDM-13232', 
    updatedon = now()
WHERE intakenumber = 'I202100554922' AND activeflag=1;
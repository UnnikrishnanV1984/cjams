-- CDM-42325- Duplicate case needs Screened Out
/*
-- Issue Description: 
    User requested to update the entered narrative from "Taking as IR Neglect due to concerns regarding youth being present for incident" 
    to "Accepting as ROH IPV based on 10/3 incident which the children were present for per Abigail S Foster Care Workers report."
  
-- Resolution: Updated the intakedastaging table
-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/	

UPDATE intakesnapshot
SET jsondata = jsonb_set(
    jsondata, 
    '{General,Narrative}', 
    to_jsonb(
        replace(
            jsondata->'General'->>'Narrative', 
            'Taking as IR Neglect due to concerns regarding youth being present for incident', 
            'Accepting as ROH IPV based on 10/3 incident which the children were present for per Abigail S Foster Care Workers report.'
        )
    )
),
updatedby = 'CDM-42325',
updatedon = now()
WHERE jsondata->'General'->>'Narrative' LIKE '%Taking as IR Neglect due to concerns regarding youth being present for incident%'
and intakenumber = 'I241013161376'
and activeflag = 1;


UPDATE intakedastaging
SET jsondata = jsonb_set(
    jsondata, 
    '{General,Narrative}', 
    to_jsonb(
        replace(
            jsondata->'General'->>'Narrative', 
            'Taking as IR Neglect due to concerns regarding youth being present for incident', 
            'Accepting as ROH IPV based on 10/3 incident which the children were present for per Abigail S Foster Care Workers report.'
        )
    )
),
updatedby = 'CDM-42325',
updatedon = now()
WHERE jsondata->'General'->>'Narrative' LIKE '%Taking as IR Neglect due to concerns regarding youth being present for incident%'
and intakenumber = 'I241013161376'
and activeflag = 1;

-- there is servicecase entacted with the intake and it's already closed so needs to replace in intakeservicerequest too.
UPDATE intakeservicerequest
SET narrative = replace(
        narrative,
        'Taking as IR Neglect due to concerns regarding youth being present for incident',
        'Accepting as ROH IPV based on 10/3 incident which the children were present for per Abigail S Foster Care Workers report.'
    ),
    updatedby = 'CDM-42325',
    updatedon = now()
WHERE narrative LIKE '%Taking as IR Neglect due to concerns regarding youth being present for incident%'
  AND intakenumber = 'I241013161376'
  AND intakeserviceid = '561f6562-de45-44b1-8b7c-0c3ce855453b';
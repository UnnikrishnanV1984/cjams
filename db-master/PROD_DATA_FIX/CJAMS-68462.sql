
/*
   Issue Description: CJAMS-68462
   Category/ Module  : Delete intake
   Root cause: Please carry out data fix to update the Jurisdiction as Baltimore County for Intake# I261014104618
   Fix type: Data fix is done to update the jurisdiction as requested
   Is code fix required : N
   Reason why no related code fix: Data fix
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE intakedastaging 
SET jsondata = REPLACE(
        jsondata::text,  
        '"countyid": "7665ca54-5374-4174-be07-a687b811a82c"', 
        '"countyid": "1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b"'
    )::jsonb,
    updatedby = 'CJAMS-68462', 
    updatedon = NOW()
WHERE intakenumber = 'I261014104618' AND activeflag = 1;
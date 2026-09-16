/*
-- Issue Description: 
I251013352453:The 396 will not allow you to print it out; it states "Fail to load PDF document"
-- Category/ Module: CPS Report
-- Root cause: Partial data of the phone details leading to fail in the download.
-- Fix Provided: update the json data to remove the empty key from the snapshot table.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
UPDATE intakesnapshot
SET jsondata = jsonb_set(
    jsondata, 
    '{persondetails,Person}', 
    (
        SELECT jsonb_agg(
            CASE 
                WHEN person->>'cjamspid' = '200534248' 
                THEN person - 'phonedetails'  -- Remove phonedetails key
                ELSE person 
            END
        )
        FROM jsonb_array_elements(jsondata->'persondetails'->'Person') AS person
    )
),
updatedby='CJAMS-61814',
updatedon = now()
WHERE jsondata @> '{"persondetails": {"Person": [{"cjamspid": "200534248"}]}}'
and intakenumber ='I251013352453' and activeflag =1;
-- CDM-35348 - Datafix of Imminent Risk Reason
/*
 -- Issue Description: In this case, Case #3240391 imminent risk reason field needs to be chaned
 
 -- Category/ Module: Case worker> service case> service plan
 -- Root cause: Incorrect entry.
 -- Fix Provided: Datafix has been added to change the imminent risk.
 -- Pull request# N/A 
 -- Reason why no related code fix: N/A
 -- Status of the code fix if already submitted and expected prod fix date: N/A
 
 */
UPDATE
    serviceplan
SET
    involvedpersons = jsonb_set(
        involvedpersons :: jsonb,
        '{persons, 0, imminentrisks}',
        '["CPBN"]' :: jsonb,
        false
    ),
    updatedby = 'CDM-35094',
    updatedon = now()
where
    objectid = '2b11eb1e-ddfa-4d3d-afa2-789f1ff3bd97'
    and serviceplanid = '06928cb7-438a-4172-9225-cc7b67b958d1';

update serviceplan
set
serviceplancandidacy = '{"candidates": [
                {
                    "candidacy": "1"
                }
            ]}',
updatedon = now(),
updatedby = 'CDM-35094'
 where serviceplanid = '06928cb7-438a-4172-9225-cc7b67b958d1';
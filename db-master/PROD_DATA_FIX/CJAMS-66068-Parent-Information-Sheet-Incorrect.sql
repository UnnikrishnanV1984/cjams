/*
   Issue Description: CJAMS-66068-Parent-Information-Sheet-Incorrect
   Category/ Module  : 
   Root cause: user want to update parent information sheet
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/ 



UPDATE snapshothist
SET snapshotdata = jsonb_set(
    snapshotdata::jsonb,
    '{0,motherdetails}',
    '{
        "dob": "1996-06-05T00:00:00",
        "akaname": " ",
        "clientid": 1732070,
        "ssnvalue": "***-**-2781",
        "parentname": "Teyona Griffith",
        "phonenumber": "410-303-4386",
        "parentaddress": "500 Western Maryland Pkwy Hagerstown MD 21740"
    }'::jsonb,
    true
),
updatedby = 'CJAMS-66068',
updatedon = now()
WHERE id = '77eaaf12-ff11-46d1-9641-5bd49abbcd3f'
  AND activeflag = 1;


UPDATE snapshothist
SET snapshotdata = jsonb_set(
    snapshotdata::jsonb,
    '{0,motherdetails}',
    '{
        "dob": "1996-06-05T00:00:00",
        "akaname": " ",
        "clientid": 1732070,
        "ssnvalue": "***-**-2781",
        "parentname": "Teyona Griffith",
        "phonenumber": "410-303-4386",
        "parentaddress": "500 Western Maryland Pkwy Hagerstown MD 21740"
    }'::jsonb,
    true
),
updatedby = 'CJAMS-66068',
updatedon = now()
WHERE id = '0b233f06-3fbd-4833-9800-6f53386143a0'
  AND activeflag = 1;

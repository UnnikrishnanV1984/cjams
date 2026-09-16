-- CDM-35187 - Data fix to subsidy rates
/*
 -- Issue Description: In this case, user selected a wrong effective date that needs to be changed in all relevant subsidy agreements and rates.
 -- Category/ Module: -
 -- Root cause: User Selected incorrect date.
 -- Fix Provided: Datafix has been added by updating adoptioncaseagreementrate and adoptioncaseagreement table.
 -- Pull request# N/A 
 -- Reason why no related code fix: N/A
 -- Status of the code fix if already submitted and expected prod fix date: N/A
 */


update
    adoptioncaseagreementrate
set
    updatedby = 'CDM-35187',
    updatedon = now(),
    enddate = '2023-08-31 08:00:00.000'
where
    transactiondate = '2023-05-08T16:13:41.621'
    and adoptionagreementrateid = '9e0ced7b-fd8a-4859-b635-3e167aea9b9c';

update
    adoptioncaseagreementrate
set
    updatedby = 'CDM-35187',
    updatedon = now(),
    startdate = '2023-09-01 08:00:00.000'
where
    transactiondate = '2023-10-31T18:52:46.108'
    and adoptionagreementrateid = 'ed567d00-29da-4c66-b10f-74fc2362e630';

update
    adoptioncaseagreement
set
    updatedby = 'CDM-35187',
    updatedon = now(),
    effectiveswitchdate = '2022-08-31 05:00:00'
where
    adoptionagreementid = '36392b88-1908-4c0a-81a1-9b39ad41fbbf';

update
    adoptioncaseagreementrate
set
    updatedby = 'CDM-35187',
    updatedon = now(),
    enddate = '2023-08-31T04:00:00'
where
    transactiondate = '2023-06-29T16:36:28.914'
    and adoptionagreementrateid = 'bf86a1a2-fc42-4327-a032-29dba440361b';

update
    adoptioncaseagreementrate
set
    updatedby = 'CDM-35187',
    updatedon = now(),
    startdate = '2023-09-01T08:00:00'
where
    transactiondate = '2023-10-31T19:19:26.605'
    and adoptionagreementrateid = 'e4f4455c-2f4f-4554-8aff-5acca99a7dcc';

update
    adoptioncaseagreement
set
    updatedby = 'CDM-35187',
    updatedon = now(),
    effectiveswitchdate = '2023-08-31T04:00:00'
where
    adoptionagreementid = 'ad9109b5-d9da-49ce-b2e4-b61d6635680b';

update
    adoptioncaseagreementrate
set
    updatedby = 'CDM-35187',
    updatedon = now(),
    startdate = '2023-09-01T08:00:00'
where
    transactiondate = '2023-10-20T19:59:23.954'
    and adoptionagreementrateid = 'd0db877a-34de-4e7d-852a-8e5f632db10b';

update
    adoptioncaseagreementrate
set
    updatedby = 'CDM-35187',
    updatedon = now(),
    enddate = '2023-08-31T04:00:00'
where
    transactiondate = '2022-10-24T17:32:25.413'
    and adoptionagreementrateid = '62af514e-e9f4-4d10-bfe2-e943b3d2375e';

update
    adoptioncaseagreement
set
    updatedby = 'CDM-35187',
    updatedon = now(),
    effectiveswitchdate = '2023-08-31T04:00:00'
where
    adoptionagreementid = '6b9ecc0d-a4f0-44f5-809d-f7e78fef37b6';
/*
Issue: CJAMS-62776 241021979438: Unable to view Comar investigation findings for the cases
       241021979438
       241021937201
       241021963249
       241021987400
Category/Module: Investigation Findings
Root cause: Incorrect final finding value is inserted in the investigation findings table for the final findings as null in string format.
            This was causing the issue and view action modal was not opening when user clicks it.
            Data fix needed to correct the values and we will investigate this issue further to get the actual insertion error.
Fix provided: We are doing a bulk Data fix for eight cases that have wrongly inserted final finding values to correct null format.
Data/Code fix ticket#: CJAMS-62776
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: We are still analysing this issue and will try to replicate it in stage environment.
*/


update investigationfinding
set finalfinding = NULL, --- updating from "null" string value to NULL
    updatedon = now(),
    updatedby = 'CJAMS-62776'
    where investigationfindingid in ('b55bde0b-db0a-493a-b217-4023212f1e4f',
        '4e8d1865-1475-47ff-9e5e-9aefbe2711c1',
        '1ba97efd-c636-495b-be1b-f1e332dc941c',
        '53692977-10b5-4fa1-b287-dbfbd74056a1',
        'ba5916e6-9563-4231-901e-9d847492e2db',
        '10731272-e36b-4e14-b9b5-0cc436feb8eb',
        'f99b23e4-bf5f-4653-9ced-e6a30afde406',
        'ad3f34fe-d3ff-4e02-8337-b217d7975532',
        '04484c76-a8d6-4e04-a7c0-5cc35ef93231')
    and activeflag =1;

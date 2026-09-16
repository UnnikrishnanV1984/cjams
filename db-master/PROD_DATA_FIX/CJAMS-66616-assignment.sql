/*
Issue: Closed cases still on dashboard
Category/Module: Workload
Root cause: Cases are closed, but the case assignment didn't get end dated that is the reason cases are appearing on workload of the user simce it had open assignment
Fix provided: Data fix has been done end date the open assignments
Data/Code fix ticket#: CJAMS-66616
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
 */
update caseassignment
set
    enddate = '2024-10-22 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('6e4ca8bb-0f96-46f0-95ea-78bf16c8fb9d')
    and activeflag = 1;

update caseassignment
set
    enddate = '2023-10-03 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('decad34d-9cf1-4065-acb4-7ada0100e20c')
    and activeflag = 1;

update caseassignment
set
    enddate = '2023-02-23 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('f3fc1aba-e2c6-4c20-94b0-5b5b9e8fe8c0')
    and activeflag = 1;

update caseassignment
set
    enddate = '2024-01-04 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('b3ab8aca-1394-4803-b929-a7043678e279')
    and activeflag = 1;

update caseassignment
set
    enddate = '2022-03-03 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('77559695-7dff-464a-ae57-ff1c57b302e5')
    and activeflag = 1;

update caseassignment
set
    enddate = '2023-08-25 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('16a5ace3-e82c-48da-acb6-07c7ea46b18b')
    and activeflag = 1;

update caseassignment
set
    enddate = '2024-05-29 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('cb9c93e2-f31c-468a-9a4a-bf79c2c7009b')
    and activeflag = 1;

update caseassignment
set
    enddate = '2024-10-02 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('8d175f88-8ccc-4a1c-a994-21f300ba2b3c')
    and activeflag = 1;

update caseassignment
set
    enddate = '2023-10-03 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('968fc7d1-93d7-4a17-b5fa-59cfc75938b0')
    and activeflag = 1;

update caseassignment
set
    enddate = '2023-12-20 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('0ba7d4c7-d70f-46e2-9c9e-3d47048084a2')
    and activeflag = 1;

update caseassignment
set
    enddate = '2024-05-21 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in (
        '99141a40-9626-4732-aa93-36d4013df280',
        '9997057f-5d5c-4e68-9a5f-16a697a40fb9'
    )
    and activeflag = 1;

update caseassignment
set
    enddate = '2024-04-15 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('76124217-6eac-47e7-8853-819f7bdb21f0')
    and activeflag = 1;

update caseassignment
set
    enddate = '2023-09-06 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('68bc0a27-6dca-4de0-8281-43a0804110cc')
    and activeflag = 1;

update caseassignment
set
    enddate = '2023-02-23 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('ea49c4f8-4853-4a57-a120-0f3e8f438779')
    and activeflag = 1;

update caseassignment
set
    enddate = '2021-12-16 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('51b40462-75a6-4589-87d2-e7b542435c1c')
    and activeflag = 1;

update caseassignment
set
    enddate = '2024-06-05 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('52bf6de6-7429-4e36-a7af-9d8376f3eed5')
    and activeflag = 1;

update caseassignment
set
    enddate = '2023-02-10 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in (
        'bccc8806-9151-45b2-af62-2bc027e7ddb4',
        'a18bc16b-4b8c-4fe6-a884-8f8fafbd3fcb'
    )
    and activeflag = 1;

update caseassignment
set
    enddate = '2023-08-24 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('d00f693b-92ed-453a-950c-da2843757124')
    and activeflag = 1;

update caseassignment
set
    enddate = '2022-07-01 00:00:00',
    updatedby = 'CJAMS-66616',
    updatedon = now ()
where
    caseassignmentid in ('ef919054-b49e-46a8-a7b1-1fc9968b36ad')
    and activeflag = 1;

/*
   Issue Description: CDM-41338
   Category/ Module  : Placement
   Root cause: user requested to add CPA home
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

insert into cjams.placementcpahomes
    (    placementcpahomeid, placementid, entrydt, entrytm, 
        exitdt, exittm, exittypecd, exitreasoncd, commentstx, 
        createts, createuserid, updatets, updateuserid, activeflag, 
        altproviderid, altplacementid, etl_userid, etl_load_date
    )
values
    (    gen_random_uuid(), 'bc9cbfd0-e9cb-42a7-b266-76eebcdb2645', '2023-12-30 00:00:00', '2023-12-30 09:00:00', 
        '2024-02-02 00:00:00', '2024-02-02 16:59:00', 'CIPS', NULL,    '', 
        now(), 'CDM-41338', now(), 'CDM-41338', 1, 
        5085906, 1556554, NULL, NULL
    );
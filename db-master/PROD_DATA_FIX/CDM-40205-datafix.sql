/*
   Issue Description: CDM-40205
   Category/ Module  : Placements
   Root cause: user wants to add missing CPA home 
   Pull request# for code fix: 5028
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/


--Create new record in placementcpahomes
insert into placementcpahomes
(placementcpahomeid, placementid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, commentstx, createts, createuserid, updatets,
updateuserid, activeflag, altproviderid, altplacementid, etl_userid, etl_load_date)
values (gen_random_uuid(), 'df8bead4-eb6a-487e-841b-f900301363fd', '2024-02-26 09:01:00', '2024-02-26 09:01:00', '2024-06-06 17:00:00', 
'2024-06-06 17:00:00', 'CIPS', NULL, '', now(), 'CDM-40205', now(), 'CDM-40205', 1, 5084027, 1841442, null, NULL);
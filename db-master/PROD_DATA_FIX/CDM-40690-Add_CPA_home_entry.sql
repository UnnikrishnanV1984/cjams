/*
  Issue Description:  CDM-40690
   Category/ Module  :  placements
   Root cause: Data Entry error- user Requested to add Cps home start date and end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
--Create new record in placementcpahomes

*/

insert into placementcpahomes 
(placementcpahomeid, placementid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, commentstx, createts, createuserid, updatets,
updateuserid, activeflag, altproviderid, altplacementid, etl_userid, etl_load_date)
values (gen_random_uuid(), '7d98c5b6-5fc6-4b87-be26-0f49bc3e1174','2023-05-30 08:00:00','2023-05-30 08:00:00','2024-06-07 12:00:00',
'2024-06-07 12:00:00','CIPS', NULL, '', now(), 'CDM-40690', now(), 'CDM-40690', 1, 5074932, 1680387, null, NULL);

insert into placementcpahomes 
(placementcpahomeid, placementid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, commentstx, createts, createuserid, updatets,
updateuserid, activeflag, altproviderid, altplacementid, etl_userid, etl_load_date)
values (gen_random_uuid(), 'd9ef2a6d-d15f-4327-a1b1-37e60841715f','2023-05-30 08:00:00','2023-05-30 08:00:00','2024-06-07 12:00:00',
'2024-06-07 12:00:00','CIPS', NULL, '', now(), 'CDM-40690', now(), 'CDM-40690', 1, 5074932, 1680385, null, NULL);


insert into placementcpahomes 
(placementcpahomeid, placementid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, commentstx, createts, createuserid, updatets,
updateuserid, activeflag, altproviderid, altplacementid, etl_userid, etl_load_date)
values (gen_random_uuid(), '80b11564-9a41-4ed9-9a7f-e912427449dd','2023-05-30 08:00:00','2023-05-30 08:00:00','2024-06-07 12:00:00',
'2024-06-07 12:00:00','CIPS', NULL, '', now(), 'CDM-40690', now(), 'CDM-40690', 1, 5074932, 1680386, null, NULL);
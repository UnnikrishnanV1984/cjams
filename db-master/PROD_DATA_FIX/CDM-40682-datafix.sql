/*
  Issue Description:CDM-40682
Category/ Module:Application
Root cause: User  requested to Add provider details in CPA home
Pull request# for code fix:
Reason why no related code fix:
Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 
*/

insert into placementcpahomes
(placementcpahomeid, placementid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, commentstx, createts, createuserid, updatets,
updateuserid, activeflag, altproviderid, altplacementid, etl_userid, etl_load_date)
values (gen_random_uuid(), 'd8160aa6-37d6-4419-8e34-64ca7cb74cd3', '2023-10-6 15:00:00', '2023-06-10 15:00:00', '2024-04-28 16:00:00', 
'2024-04-28 16:00:00', 'CIPS', NULL, '', now(), 'CDM-40682', now(), 'CDM-40682', 1, 5096216, 1756230, null, NULL);
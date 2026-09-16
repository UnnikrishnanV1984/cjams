/*
  Issue Description:  CDM-40162
   Category/ Module  :  placements
   Root cause: Data Entry error- user Requested to add Cps home start date and end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


--Create new record in placementcpahomes
insert into placementcpahomes
(placementcpahomeid, placementid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, commentstx, createts, createuserid, updatets,
updateuserid, activeflag, altproviderid, altplacementid, etl_userid, etl_load_date)
values (gen_random_uuid(), '9ddc329c-19f7-4117-be2d-1a0da64b63a1', '2019-01-28 09:00:00', '2019-01-28 09:00:00', '2019-03-01 09:00:00', 
'2019-03-01 09:00:00', 'CIPS', NULL, '', now(), 'CDM-40162', now(), 'CDM-40162', 1, 5033670, 332831, null, NULL);
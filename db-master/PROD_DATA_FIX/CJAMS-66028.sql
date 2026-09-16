
/*
Issue: CJAMS, Placement (CPA Home)
Root Cause:  This CPA home needs to be added for all three children with a start date of 1/30/26 and and end date of 2/6/26.
Fix Provided (Data Fix Only): Data fix was done by adding CPA home record for all three children.
Data/Code fix ticket#: CJAMS-66028
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Inserted children in 'placementcpahomes' table through the database.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
insert into placementcpahomes
(placementcpahomeid, placementid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, commentstx, createts, createuserid, updatets,
updateuserid, activeflag, altproviderid, altplacementid, etl_userid, etl_load_date)
values (gen_random_uuid(), '92ff22c7-e301-4395-9af9-32707e14abe7','2026-01-30 00:00:00',null ,'2026-02-06 00:00:00',
null,'CIPS', NULL, '', now(), 'CJAMS-66028', now(), 'CJAMS-66028', 1, 6202452 ,1939484 , null, null);

insert into placementcpahomes
(placementcpahomeid, placementid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, commentstx, createts, createuserid, updatets,
updateuserid, activeflag, altproviderid, altplacementid, etl_userid, etl_load_date)
values (gen_random_uuid(), 'ce21fe4f-50cc-452a-9365-942fa401f633','2026-01-30 00:00:00', null,'2026-02-06 00:00:00',
null,'CIPS', NULL, '', now(), 'CJAMS-66028', now(), 'CJAMS-66028', 1, 6202452 ,1914254 , null, null);

insert into placementcpahomes
(placementcpahomeid, placementid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, commentstx, createts, createuserid, updatets,
updateuserid, activeflag, altproviderid, altplacementid, etl_userid, etl_load_date)
values (gen_random_uuid(), '74637d77-fe21-4add-af34-f2f3db6a59bb','2026-01-30 00:00:00',null,'2026-02-06 00:00:00',
null,'CIPS', NULL, '', now(), 'CJAMS-66028', now(), 'CJAMS-66028', 1, 6202452,1914255 , null, null);
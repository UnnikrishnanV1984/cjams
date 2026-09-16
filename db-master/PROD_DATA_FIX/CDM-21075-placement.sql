/*
   Issue Description: CDM-21075
   Category/ Module  :  Update CPA end date
   Root cause: user requeseted to update it
   Pull request# for code fix: 7398
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update placementcpahomes set exitdt = '2021-12-12 09:59:00',exittm = '2021-12-12 09:59:00', updatets = now(), updateuserid = 'CDM-21075' where placementcpahomeid = 'a7c9b0f5-50c2-4567-a774-3c2dfe2cbff2';


--insert new record

INSERT INTO cjams.placementcpahomes
(placementcpahomeid, placementid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, commentstx, createts, createuserid, updatets, updateuserid, activeflag, altproviderid, altplacementid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), 'd8d30f7c-e308-403d-afc0-22e91e8e95bf', '2021-12-12 10:00:00.000', '2021-12-12 10:00:00.000', '2022-10-10 00:00:00.000', '2022-10-10 13:00:00.000', NULL, NULL, NULL, now(), 'CDM-21075', now(), 'CDM-21075', 1, 5065261, 333202, NULL, NULL);
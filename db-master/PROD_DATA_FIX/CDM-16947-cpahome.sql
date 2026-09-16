/*
   Issue Description: CDM-18247
   Category/ Module  :  Add provider
   Root cause: user asked to add new cpa home
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


INSERT INTO cjams.placementcpahomes
(placementcpahomeid, placementid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, commentstx, createts, createuserid, updatets, updateuserid, activeflag, altproviderid, altplacementid, etl_userid, etl_load_date)
VALUES('9258eb0f-687b-4f25-aa29-bb576d26b171'::uuid, 'a0910e48-b0d8-400e-8e48-a4585f95e056'::uuid, '2019-11-19 00:00:00.000', '1970-01-01 18:00:00.000', '2021-08-23 00:00:00.000', '1970-01-01 18:00:00.000', 'CIP', 'PIPL', 'Aszia was placed with Pressley Ridge foster parent Joyce Smith on 11/19/19.  However, Ms. Smith is not listed as a CPA home.', '2019-09-26 13:03:07.000', 'GLO653430', '2020-03-16 13:32:56.000', 'CDM-16947', 1, 5062004, 325754, NULL, NULL);
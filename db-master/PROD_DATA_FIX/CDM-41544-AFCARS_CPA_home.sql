/*
   Issue Description: CDM-41544
   Category/ Module  : add CPA home
   Root cause: user wants add CPA home for 
   Client ID: 4009606 (ELIJAH JOHNSON)
    Exit Reason: Permanency Step: Placement with Siblings or Own Child
   Client ID: 4009611 (AYDEN WILLIAMS)
    Exit Reason: Reunify with Parent or legal guardian

   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 4009606 (ELIJAH JOHNSON)
insert into placementcpahomes 
(placementcpahomeid, placementid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, commentstx, createts, createuserid, updatets,
updateuserid, activeflag, altproviderid, altplacementid, etl_userid, etl_load_date)
values (gen_random_uuid(), 'bd256f15-febd-42b6-9baa-a0dfc98ffd22','2023-11-21  00:00:00','2023-11-21 14:00:00','2023-11-27  00:00:00',
'2023-11-27 12:00:00','CIP', NULL, '', now(), 'CDM-41544', now(), 'CDM-41544', 1,5024602 , 1780545, null, NULL);

--CPS home as 5024602 Tina Cornish CPA Home

-- 4009611 (AYDEN WILLIAMS)
insert into placementcpahomes 
(placementcpahomeid, placementid, entrydt, entrytm, exitdt, exittm, exittypecd, exitreasoncd, commentstx, createts, createuserid, updatets,
updateuserid, activeflag, altproviderid, altplacementid, etl_userid, etl_load_date)
values (gen_random_uuid(), 'ab7066cd-dcdb-46e2-bb67-e937be6baf81','2023-11-21  00:00:00','2023-11-21 14:00:00','2023-11-27  00:00:00',
'2023-11-27 12:00:00','PLCC', NULL, '', now(), 'CDM-41544', now(), 'CDM-41544', 1,5024602 , 1780546, null, NULL);

/*
   Issue Description: CDM-24463
   Category/ Module  : Prod data fix to remove adoption break the link
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


--INSERT INTO cjams.adoptionbreakthelink
--(adoptionbreakthelinkid, adoptionplanningid, legallyfree, adoptiveplacement, placementagreement, agreementsigneddate, adoptionfinalization, associatedcourtorderdate, finalizationdate, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, courtorderid, etl_userid, etl_load_date)
--VALUES('478c29d1-219f-4bb7-a86b-60230634b1b0'::uuid, '2414d600-3a27-46e1-9f66-20aa84cd9b61'::uuid, NULL, 1, 1, '2022-05-04 10:00:00.000', 1, '2022-08-17 04:00:00.000', '2022-08-17 09:00:00.000', 1, '8a06aed2-7164-477d-979f-071786254036', '2022-08-17 11:53:35.000', '8a06aed2-7164-477d-979f-071786254036', '2022-08-17 11:53:35.000', '2022-08-17 11:53:35.000', NULL, NULL, NULL, NULL, NULL);
DELETE FROM cjams.adoptionbreakthelink
WHERE adoptionbreakthelinkid='478c29d1-219f-4bb7-a86b-60230634b1b0'::uuid;

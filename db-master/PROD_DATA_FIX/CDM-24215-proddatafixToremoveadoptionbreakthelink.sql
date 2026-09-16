/*
   Issue Description: CDM-24215
   Category/ Module  : Prod data fix to remove adoption break the link
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



DELETE FROM cjams.adoptionbreakthelink
WHERE adoptionbreakthelinkid='6925c909-b3ea-4d1e-b1bb-b556d3b9fc1a'::uuid;


-- INSERT INTO cjams.adoptionbreakthelink
-- (adoptionbreakthelinkid, adoptionplanningid, legallyfree, adoptiveplacement, placementagreement, agreementsigneddate, adoptionfinalization, associatedcourtorderdate, finalizationdate, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, courtorderid, etl_userid, etl_load_date)
-- VALUES('6925c909-b3ea-4d1e-b1bb-b556d3b9fc1a'::uuid, 'd4794f19-fdb3-4e52-81f5-78f633e730fd'::uuid, NULL, 1, 1, '2022-05-10 10:00:00.000', 1, '2022-08-03 04:00:00.000', '2022-08-03 10:30:00.000', 0, '857ed837-155d-4928-864a-10c909324a00', '2022-08-03 14:47:20.000', '857ed837-155d-4928-864a-10c909324a00', '2022-08-03 14:47:20.000', '2022-08-03 14:47:20.000', NULL, NULL, NULL, NULL, NULL);

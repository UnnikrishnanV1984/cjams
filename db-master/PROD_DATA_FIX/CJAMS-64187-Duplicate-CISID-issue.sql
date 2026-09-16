/*
  Issue Description: CJAMS-64187 CIS did not change during break link
  Category/ Module : User Search
  Root cause: CISID of Bioclient getting updated in the adopted client due to which person search is returning two records for same CISID.
              This is happening due to code issue while creating an adoptioncase. We are including the insertion of IRN details from the biocase into the new
              person identifier table which is creating this duplicate entry in the Adopted client record
  Fix Provided: Data fix has been done to remove the duplicate person from the personidentifier table 
                Expected Data Issue correction
                Search CIS ID - 533070301 should correspond to only one record with cjamspid 204038641
                Search CIS ID - 556074893 should correspond to only one record with cjamspid 204431377
  Regression Impacts: N/A
  Is Code fix needed: Yes
  Code fix ticket # : TBD
  Reason why no related code fix: This is due to code issue and we will fix it as the part of CDM.
*/


-- INSERT INTO cjams.personidentifier
-- (personidentifierid, personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
-- VALUES('d8378906-131b-43bf-a3c5-987623ab6920', 'ac128977-742a-4fd3-9f39-54c651df126c', 'IRN', '533070301', 'faaed8a5-cc16-47fc-a733-f77532c69ffa', '2025-12-16 13:39:35.719', 'faaed8a5-cc16-47fc-a733-f77532c69ffa', '2025-12-16 13:39:35.719', 1, '2025-12-16 13:39:35.719', NULL, NULL, NULL, NULL, NULL);


delete from personidentifier where personidentifierid in  ('d8378906-131b-43bf-a3c5-987623ab6920');
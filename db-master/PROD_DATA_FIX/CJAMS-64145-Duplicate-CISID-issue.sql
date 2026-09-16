/*
  Issue Description: CJAMS-64145 CIS number
  Category/ Module : User Search
  Root cause: Duplicate CISID of Bioclient getting updated in the adopted client which due to which person search is returning two records for same CISID.
              This is happening due to code issue while creating an adoptioncase. We are including the insertion of IRN details from the biocase into the new
              person identifier table which is creating this duplicate entry in the Adopted client record
  Fix Provided: Data fix has been done to remove the duplicate person from the personidentifier table 
                Expected Data Issue correction
                Search CIS ID - 507066914 should correspond to only one record with cjamspid 202017197
                Search CIS ID - 584074699 should correspond to only one record with cjamspid 204370547
  Regression Impacts: N/A
  Is Code fix needed: Yes
  Code fix ticket # : TBD
  Reason why no related code fix: This is due to code issue and we will fix it as the part of CDM.
*/


-- INSERT INTO cjams.personidentifier
-- (personidentifierid, personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
-- VALUES('95b82fe2-9bb3-4598-b4ca-aa73bc688672', '2e935e87-6a5f-47ad-9f99-31fa8ab7fda8', 'IRN', '507066914', '415e105c-c194-4f2a-b96f-d7f97823f0e1', '2025-12-04 15:30:45.503', '415e105c-c194-4f2a-b96f-d7f97823f0e1', '2025-12-04 15:30:45.503', 1, '2025-12-04 15:30:45.503', NULL, NULL, NULL, NULL, NULL);


delete from personidentifier where personidentifierid in  ('95b82fe2-9bb3-4598-b4ca-aa73bc688672');
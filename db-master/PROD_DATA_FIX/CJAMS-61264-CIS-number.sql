/*
  Issue Description: CJAMS-61264 231030216025:Angela Rivera Alvarez (birth name) was adopted and her name changed to Angela Swygert. 
                     They both have the same CIS#: 553068033
  Category/ Module : User Search
  Root cause: Both users are having the same CIS id's as it is an adopted child and data fix is done to remove one of them from the person search
  Fix Provided: Data fix has been done to remove the duplicate person from the personidentifier table 
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: Duplicate person name show in search and data fix needed to correct it.
*/

-- INSERT INTO cjams.personidentifier
-- (personidentifierid, personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
-- VALUES('a231d5e7-b994-4216-a9fc-0e205586421b'::uuid, '69b4fedb-73a8-44c6-a624-4a18f14db308'::uuid, 'IRN', '553068033', 'CJAMS-61264', '2025-10-10 17:47:07.954', 'd6409d68-18d9-4e04-a925-053a99e364dc', '2025-04-29 11:00:02.970', 0, '2025-04-29 11:00:02.970', NULL, NULL, NULL, NULL, NULL);

delete from personidentifier where personidentifierid = 'a231d5e7-b994-4216-a9fc-0e205586421b';
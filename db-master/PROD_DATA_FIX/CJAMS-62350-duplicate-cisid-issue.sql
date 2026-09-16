/*
  Issue Description: CJAMS-62350 Two clients are available for the same CIS ID's. We need to correct it.
  Category/ Module : User Search
  Root cause: Both users are having the same CIS id's inserted for adopted child and data fix is done to remove one of them from the person search.
              We are still analysing the root cause of this issue and code fix might be needed after further analysis.
  Fix Provided: Data fix has been done to remove the duplicate person from the personidentifier table 
                Expected Data Issue correction
                Search CIS ID - 533072892 should correspond to only one record - 204223910
                Search CIS ID - 470051879 should correspond to only one record - 3684312
  Regression Impacts: N/A
  Is Code fix needed: TBD
  Code fix ticket # : N/A
  Reason why no related code fix: We are analysing the root cause and we might need a code fix ticket if this is an issue in CJAMS side.
*/

-- INSERT INTO cjams.personidentifier
-- (personidentifierid, personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
-- VALUES('49cfe981-1ac7-4ea5-a7e9-21e08b9fff19', '90f52ccf-e70d-463c-bb74-35ec5a88232e', 'IRN', '533072892', 'irn_user', '2025-10-30 17:51:45.050', 'irn_user', '2025-10-14 13:55:48.910', 0, '2025-10-14 13:55:48.910', NULL, NULL, NULL, NULL, NULL);


-- INSERT INTO cjams.personidentifier
-- (personidentifierid, personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
-- VALUES('e5d4e372-8071-45e4-9d70-261626395b68', '90f52ccf-e70d-463c-bb74-35ec5a88232e', 'IRN', '533072892', 'irn_user', '2025-10-30 17:51:45.050', 'irn_user', '2025-10-30 17:51:45.050', 1, '2025-10-30 17:51:45.050', NULL, NULL, NULL, NULL, NULL);



delete from personidentifier where personidentifierid in  ('49cfe981-1ac7-4ea5-a7e9-21e08b9fff19','e5d4e372-8071-45e4-9d70-261626395b68');
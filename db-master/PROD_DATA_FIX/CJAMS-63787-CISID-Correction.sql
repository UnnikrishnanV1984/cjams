/*
  Issue Description: CJAMS-63787 CIS number
  Category/ Module : User Search
  Root cause: Both users are having the same CIS id's inserted for adopted child and data fix is done to remove one of them from the person search.
              We are still analysing the root cause of this issue and code fix might be needed after further analysis.
              MDT-126381928 - Zaydan Fulp (Bio record - with SSN) - IRN 470051879, CJAMS~3684312
              MDT-156202827 - Zaydan York (adopted record without SSN) - IRN 500889064, CJAMS~204223910
  Fix Provided: Data fix has been done to remove the duplicate person from the personidentifier table 
                Expected Data Issue correction
                Search CIS ID - 559068712 should correspond to only one record with cjamspid 202817942
                Search CIS ID - 568073558 should correspond to only one record with cjamspid 204331598
  Regression Impacts: N/A
  Is Code fix needed: TBD
  Code fix ticket # : N/A
  Reason why no related code fix: We are analysing the root cause and we might need a code fix ticket if this is an issue in CJAMS side.
*/

-- INSERT INTO cjams.personidentifier
-- (personidentifierid, personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
-- VALUES('0960cc95-fa0f-4595-91ea-f1680c6115d1', '5d0d29a3-363b-4479-8f13-d97aba29e556', 'IRN', '559068712', '44a87d4b-ab4e-4ee8-9cdd-a78f3f615f68', '2025-11-25 12:42:10.750', '44a87d4b-ab4e-4ee8-9cdd-a78f3f615f68', '2025-11-25 12:42:10.750', 1, '2025-11-25 12:42:10.750', NULL, NULL, NULL, NULL, NULL);


delete from personidentifier where personidentifierid in  ('0960cc95-fa0f-4595-91ea-f1680c6115d1');
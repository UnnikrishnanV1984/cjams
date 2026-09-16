 /* Issue Description: CJAMS-62350 Two clients are available for the same CIS ID's. We need to correct it.
  Category/ Module : User Search
  Root cause: Both users are having the same CIS id's inserted for adopted child and data fix is done to remove one of them from the person search.
              We have fixed this issue as the part of CIDM-10967 and this .didn't still go in production. User tried to update the middle name again
              and the CISID got updated incorrectly
  Fix Provided: Data fix has been done to remove the duplicate person from the personidentifier table 
                Expected Data Issue correction
                Search CIS ID - 533072892 should correspond to only one record - 204223910
                Search CIS ID - 470051879 should correspond to only one record - 3684312
  Regression Impacts: N/A
  Is Code fix needed: yes
  Code fix ticket # : CIDM-10967
  Reason why no related code fix: This has been fixed as the part of CIDM-10967 which is not still in production.
*/

--Backup for the incorrect insertion record

-- INSERT INTO cjams.personidentifier
-- (personidentifierid, personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
-- VALUES('b84edcba-6e7f-4b40-bba2-e7028d2f8cc7'::uuid, '90f52ccf-e70d-463c-bb74-35ec5a88232e'::uuid, 'IRN', '533072892', 'irn_user', '2025-10-31 09:12:22.261', 'irn_user', '2025-10-31 09:12:22.261', 1, '2025-10-31 09:12:22.261', NULL, NULL, NULL, NULL, NULL);


update personidentifier 
set personidentifiervalue = '470051879',
	updatedby = 'CJAMS-62350',
	updatedon = now()
where personidentifierid = 'b84edcba-6e7f-4b40-bba2-e7028d2f8cc7'	
and activeflag =1;
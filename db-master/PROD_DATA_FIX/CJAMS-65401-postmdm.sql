 /*
   Issue Description: CJAMS-65401 MDM failure 
   Category/ Module  :  Person MDM
   Root cause: Postmdm failures
   Fix provided : Postmdm call and updated the mdm id
   Code fix ticket#: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date:  NA
   Backup before update/ delete: NA
*/

update cjams.personidentifier set activeflag=0, updatedby='CJAMS-65401', updatedon=now() 
where personid='74288e3d-1fdb-4e46-b3b1-ca502b168006'
and personidentifiertypekey='MDM_ID';

INSERT INTO cjams.personidentifier
(personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
VALUES('74288e3d-1fdb-4e46-b3b1-ca502b168006', 'MDM_ID', 'MDT-125994021', 'CJAMS-65401', now(), 'CJAMS-65401', now(), 1, now(), NULL, NULL, NULL, NULL, NULL);

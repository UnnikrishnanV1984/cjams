
/*
   Issue Description: CJAMS-66063 MDM failure 
   Category/ Module  :  Person MDM
   Root cause: Postmdm failures
   Fix provided : Postmdm call and updated the mdm id
   Code fix ticket#: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date:  NA
   Backup before update/ delete: NA
*/
update cjams.personidentifier set activeflag=0, updatedby='CJAMS-66063', updatedon=now() 
where personid in ('ab6346d5-500e-4a42-aa4a-a4d66f9547ad','f77c4cb7-9997-43d3-9fc9-d7929b55380b','f814c878-a78a-41b1-a3b1-dfd9bdddd7ed',
'b658f3cc-d5f4-4768-8e48-a84686f720bf')
and personidentifiertypekey='MDM_ID';

INSERT INTO cjams.personidentifier
(personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
VALUES('ab6346d5-500e-4a42-aa4a-a4d66f9547ad', 'MDM_ID', 'MDT-156508843', 'CJAMS-66063', now(), 'CJAMS-66063', now(), 1, now(), NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.personidentifier
(personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
VALUES('f77c4cb7-9997-43d3-9fc9-d7929b55380b', 'MDM_ID', 'MDT-156508848', 'CJAMS-66063', now(), 'CJAMS-66063', now(), 1, now(), NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.personidentifier
(personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
VALUES('f814c878-a78a-41b1-a3b1-dfd9bdddd7ed', 'MDM_ID', 'MDT-156498979', 'CJAMS-66063', now(), 'CJAMS-66063', now(), 1, now(), NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.personidentifier
(personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon, insertedby, insertedon, activeflag, effectivedate, expirationdate, old_id, "timestamp", etl_userid, etl_load_date)
VALUES('b658f3cc-d5f4-4768-8e48-a84686f720bf', 'MDM_ID', 'MDT-156498980', 'CJAMS-66063', now(), 'CJAMS-66063', now(), 1, now(), NULL, NULL, NULL, NULL, NULL);

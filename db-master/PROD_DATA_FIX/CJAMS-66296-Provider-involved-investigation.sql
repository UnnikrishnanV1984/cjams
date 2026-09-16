/*
Issue:CJAMS-66296-CHANGE-TO-PROVIDER-INVOLVED
Category/Module: SDM/Maltreatment 
Root cause: Need the data fix to check the checkbox to Yes for the Provider Involved Maltreatment in both victims as below 
Fix provided:  Provided needed datafix.     
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error.
*/


update investigationallegation
set isproviderinvolved = 1,
    updatedon =now(),
    updatedby = 'CJAMS-66296'
where investigationid = 'f8e7930a-955f-41fc-b74d-6b40187aee8e'
and activeflag = 1; 


update investigationmaltreatment
set providerid='5086498',
    providername='Center for Social Change - 8621 Pilsen Rd DDA',
    providerphonenumber='8621 Pilsen Rd Randallstown Md 21133',
    updatedon =now(),
    updatedby = 'CJAMS-66296'
where investigationid = 'f8e7930a-955f-41fc-b74d-6b40187aee8e' and activeflag = 1;


INSERT INTO cjams.allegationprovidermaltreatment
(allegationprovidermaltreatmentid, investigationallegationid, 
providermaltreatmenttypekey, activeflag, insertedby, updatedby, effectivedate, 
insertedon, updatedon, old_id)
VALUES(gen_random_uuid(), '48a72ceb-6a35-4db4-9235-45b4cf88429e', 'FCPS', 1,
'CJAMS-66296', 'CJAMS-66296', '2025-02-21 16:11:57', now(), now(), NULL);


INSERT INTO cjams.allegationprovidermaltreatment
(allegationprovidermaltreatmentid, investigationallegationid, 
providermaltreatmenttypekey, activeflag, insertedby, updatedby, effectivedate, 
insertedon, updatedon, old_id)
VALUES(gen_random_uuid(), '153dc691-5869-45e2-85a7-9bbb463a3b9d', 'FCPS', 1,
'CJAMS-66296', 'CJAMS-66296', '2025-02-28 16:11:57', now(), now(), NULL);
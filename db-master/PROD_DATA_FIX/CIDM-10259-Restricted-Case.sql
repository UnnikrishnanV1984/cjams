/*
   Issue Description: CIDM-10259
   Category/ Module  : Prod data fix to provide Access to Restricted Case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


 INSERT INTO cjams.restricteditems
(objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, etl_userid, etl_load_date)
VALUES('SERVICE', 'aedcc939-a2c7-418b-9488-c6e211576723', '34aa88ee-492f-4b39-800a-9fa0d8b5cef8', NULL, false, false, false, 'CIDM-10259', 'CIDM-10259', now(), now(), 1, NULL, NULL);


INSERT INTO cjams.restricteditems
(restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, etl_userid, etl_load_date, roletypekey)
VALUES(gen_random_uuid(), 'SERVICE', 'aedcc939-a2c7-418b-9488-c6e211576723', 'd0517441-7a44-4858-84b4-7965fda851bd', NULL, false, false, false, 'CIDM-10259', 'CIDM-10259', now(), now(), 1, NULL, NULL, 'CWCW');
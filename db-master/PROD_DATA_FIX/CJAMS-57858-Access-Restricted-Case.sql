/*
   Issue Description: CJAMS-57858
   Category/ Module  : Prod data fix to provide Access to Restricted Case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

INSERT INTO cjams.restricteditems
(restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, etl_userid, etl_load_date, roletypekey)
VALUES(gen_random_uuid(), 'SERVICE', '51c2f9bf-f5b8-43cd-9745-e6579b521eab', 'd0517441-7a44-4858-84b4-7965fda851bd', NULL, false, false, false, 'CJAMS-57858', 'CJAMS-57858', now(), now(), 1, NULL, NULL, 'CWIW');

INSERT INTO cjams.restricteditems
(restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, etl_userid, etl_load_date, roletypekey)
VALUES(gen_random_uuid(), 'SERVICE', '51c2f9bf-f5b8-43cd-9745-e6579b521eab', '34aa88ee-492f-4b39-800a-9fa0d8b5cef8', NULL, false, false, false, 'CJAMS-57858', 'CJAMS-57858', now(), now(), 1, NULL, NULL, 'CWSP');
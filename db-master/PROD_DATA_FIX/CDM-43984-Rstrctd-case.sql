/*
   Issue Description: CDM-43984
   Category/ Module  :Restricted case.
   Root cause: user wants to change
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   
*/

INSERT INTO cjams.restricteditems
(restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, etl_userid, etl_load_date, roletypekey)
VALUES(gen_random_uuid(), 'SERVICE', '399a0341-007d-4d2f-bb98-368812cf7c0a', 'd0517441-7a44-4858-84b4-7965fda851bd', NULL, false, false, false, 'CDM-43984', 'CDM-43984', now(), now(), 1, NULL, NULL, 'CWIW');

INSERT INTO cjams.restricteditems
(restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, etl_userid, etl_load_date, roletypekey)
VALUES(gen_random_uuid(), 'SERVICE', '399a0341-007d-4d2f-bb98-368812cf7c0a', '34aa88ee-492f-4b39-800a-9fa0d8b5cef8', NULL, false, false, false, 'CDM-43984', 'CDM-43984', now(), now(), 1, NULL, NULL, 'CWIW');

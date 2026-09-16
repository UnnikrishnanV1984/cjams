/*
   Issue Description: CDM-10127
   Category/ Module  : Restricted Access
 
   Data fix: restricted access given to the user donna.duvall
*/


INSERT INTO cjams.restricteditems
(restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, etl_userid, etl_load_date, roletypekey)
VALUES(gen_random_uuid(), 'Servicerequest', '0c258f1e-9f35-4572-891c-540a4cef370f', '34aa88ee-492f-4b39-800a-9fa0d8b5cef8', NULL, false, false, false, 'CIDM-10127', 'CIDM-10127', now(), now(), 1, NULL, NULL, 'CWCW');


INSERT INTO cjams.restricteditems
(restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, etl_userid, etl_load_date, roletypekey)
VALUES(gen_random_uuid(), 'Servicerequest', '0c258f1e-9f35-4572-891c-540a4cef370f', 'd0517441-7a44-4858-84b4-7965fda851bd', NULL, false, false, false, 'CIDM-10127', 'CIDM-10127', now(), now(), 1, NULL, NULL, 'CWCW');
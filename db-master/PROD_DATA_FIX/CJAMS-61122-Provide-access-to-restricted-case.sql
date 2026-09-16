/*
Issue Description:CJAMS-61122 Urgent- Access to Restricted case for SSA
Category/Module: Restricted case 
Root cause: User requesting access to restricted case  #221030017904 for tara.newcomer3@maryland.gov 
Fix provided: Data fix has been done to provide access to the restricted case to tara.newcomer3@maryland.gov
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#:N/A
Reason why no related code fix: This is a know case restriction feature and data fix is needed to resolve it.
*/

--case number #221030017904
-- object id 783d25d0-ca44-4234-8393-0f631c02f923
--security user id : 34aa88ee-492f-4b39-800a-9fa0d8b5cef8

INSERT INTO cjams.restricteditems
(restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, etl_userid, etl_load_date, roletypekey)
VALUES(gen_random_uuid(), 'SERVICE', '783d25d0-ca44-4234-8393-0f631c02f923', '34aa88ee-492f-4b39-800a-9fa0d8b5cef8', NULL, false, false, false, 'CJAMS-61122', 'CJAMS-61122', now(),now(), 1, NULL, NULL, 'CWIW');    	
/*
Issue Description:CJAMS-61270 Access to Restricted case for SSA
Category/Module: Restricted case 
Root cause: User requesting access to restricted case  #251023004811 for tara.newcomer3@maryland.gov 
Fix provided: Data fix has been done to provide access to the restricted case to tara.newcomer3@maryland.gov
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#:N/A
Reason why no related code fix: This is a know case restriction feature and data fix is needed to resolve it.
*/

--case number #251023004811
-- object id ac152cd4-66e1-42b9-9694-a299d207f3b0
--security user id : 34aa88ee-492f-4b39-800a-9fa0d8b5cef8
INSERT INTO cjams.restricteditems
(restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, etl_userid, etl_load_date, roletypekey)
VALUES(gen_random_uuid(), 'SERVICE', 'ac152cd4-66e1-42b9-9694-a299d207f3b0', '34aa88ee-492f-4b39-800a-9fa0d8b5cef8', NULL, false, false, false, 'CJAMS-61270', 'CJAMS-61270', now(), now(), 1, NULL, NULL, 'CWIW');
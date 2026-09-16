/*
   Issue Description: CDM-23329
   Category/ Module  : Prod data fix to provide Access to Restricted Case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


--Susan McEachron
INSERT INTO cjams.restricteditems
(objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, etl_userid, etl_load_date)
VALUES('SERVICE', '8d136e92-f63b-4fe8-acd9-00bebf56def0', '7938acb3-e80b-4caa-9ef0-1ddd9725a54f', NULL, false, false, false, 'CDM-23329', 'CDM-23329', Now(), Now(), 1, NULL, NULL);

-- Nikia Agent

INSERT INTO cjams.restricteditems
(objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, etl_userid, etl_load_date)
VALUES('SERVICE', '8d136e92-f63b-4fe8-acd9-00bebf56def0', '1b842adc-53a9-4345-8e65-b46973f24057', NULL, false, false, false, 'CDM-23329', 'CDM-23329', Now(), Now(), 1, NULL, NULL);


-- Antonia Daniels
INSERT INTO cjams.restricteditems
(objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, etl_userid, etl_load_date)
VALUES('SERVICE', '8d136e92-f63b-4fe8-acd9-00bebf56def0', '6e915a2a-98f9-4d63-9880-9aeff8d2179d', NULL, false, false, false, 'CDM-23329', 'CDM-23329', Now(), Now(), 1, NULL, NULL);

-- Janet Bridges
INSERT INTO cjams.restricteditems
(objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, etl_userid, etl_load_date)
VALUES('SERVICE', '8d136e92-f63b-4fe8-acd9-00bebf56def0', 'e8c75833-c2bb-4381-990d-0f520f021f93', NULL, false, false, false, 'CDM-23329', 'CDM-23329', Now(), Now(), 1, NULL, NULL);


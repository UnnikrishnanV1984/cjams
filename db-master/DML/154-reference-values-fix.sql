

INSERT INTO cjams.referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) 
VALUES 
('595',50042,'Agency to provide transportation','Agency to provide transportation','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL),
('596',50042,'Other','Other','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL),
('597',50042,'Parents to provide transportation','Parents to provide transportation','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL),
('598',50042,'Shared transportation','Shared transportation','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL),
('599',50042,'Transportation not required','Transportation not required','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL),
('600',50042,'Foster Parent','Foster Parent','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL);

INSERT INTO cjams.referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) 
VALUES 
('1244',50084,'1 time per week','1 time per week','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL),
('1245',50084,'2 times per week','2 times per week','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL),
('1246',50084,'3 times per week','3 times per week','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL),
('1247',50084,'Other','Other','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL),
('1248',50084,'Unlimited','Unlimited','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL),
('1249',50084,'Unscheduled','Unscheduled','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL);

INSERT INTO cjams.referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon,parenttypeid,parentkey,mdmcode) 
VALUES 
('1472',500108,'1 hour','1 hour','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL),
('1473',500108,'2 hours','2 hours','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL),
('1474',500108,'Day visit','Day visit','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL),
('1475',500108,'Less than 1 hour','Less than 1 hour','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL),
('1476',500108,'Other','Other','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL),
('1477',500108,'Overnight','Overnight','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL),
('1478',500108,'Weekend','Weekend','CW',1,1,'Admin',now(),'Admin',now(),NULL,NULL,NULL);


INSERT INTO cjams.referencetype(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES
(50042, 'Child and Visitor Transportation', 'childandvisitortransportation', 1, 'Admin', now(), 'Admin', now(), NULL),
(50084, 'Frequency of Planned Visits', 'frequencyofplannedvisits', 1, 'Admin', now(), 'Admin', now(), NULL),
(500108, 'Length of Planned Visit', 'lengthofplannedvisit', 1, 'Admin', now(), 'Admin', now(), NULL);


UPDATE cjams.tb_picklist_values SET sort_order_no=1 WHERE picklist_type_id=1397 AND picklist_value_cd='6038';
UPDATE cjams.tb_picklist_values SET sort_order_no=9 WHERE picklist_type_id=1397 AND picklist_value_cd='6039';
UPDATE cjams.tb_picklist_values SET sort_order_no=10 WHERE picklist_type_id=1397 AND picklist_value_cd='6040';
UPDATE cjams.tb_picklist_values SET sort_order_no=11 WHERE picklist_type_id=1397 AND picklist_value_cd='6041';
UPDATE cjams.tb_picklist_values SET sort_order_no=2 WHERE picklist_type_id=1397 AND picklist_value_cd='6042';
UPDATE cjams.tb_picklist_values SET sort_order_no=14 WHERE picklist_type_id=1397 AND picklist_value_cd='6043';
UPDATE cjams.tb_picklist_values SET sort_order_no=12 WHERE picklist_type_id=1397 AND picklist_value_cd='6044';
UPDATE cjams.tb_picklist_values SET sort_order_no=15 WHERE picklist_type_id=1397 AND picklist_value_cd='6045';
UPDATE cjams.tb_picklist_values SET sort_order_no=13 WHERE picklist_type_id=1397 AND picklist_value_cd='6046';
UPDATE cjams.tb_picklist_values SET sort_order_no=3 WHERE picklist_type_id=1397 AND picklist_value_cd='6047';
UPDATE cjams.tb_picklist_values SET sort_order_no=16 WHERE picklist_type_id=1397 AND picklist_value_cd='6048';
UPDATE cjams.tb_picklist_values SET sort_order_no=4 WHERE picklist_type_id=1397 AND picklist_value_cd='6049';
UPDATE cjams.tb_picklist_values SET sort_order_no=17 WHERE picklist_type_id=1397 AND picklist_value_cd='6050';
UPDATE cjams.tb_picklist_values SET sort_order_no=5 WHERE picklist_type_id=1397 AND picklist_value_cd='6051';
UPDATE cjams.tb_picklist_values SET sort_order_no=18 WHERE picklist_type_id=1397 AND picklist_value_cd='6052';
UPDATE cjams.tb_picklist_values SET sort_order_no=6 WHERE picklist_type_id=1397 AND picklist_value_cd='6053';
UPDATE cjams.tb_picklist_values SET sort_order_no=7 WHERE picklist_type_id=1397 AND picklist_value_cd='6054';
UPDATE cjams.tb_picklist_values SET sort_order_no=8 WHERE picklist_type_id=1397 AND picklist_value_cd='6055';
UPDATE cjams.tb_picklist_values SET sort_order_no=19 WHERE picklist_type_id=1397 AND picklist_value_cd='6056';
UPDATE cjams.tb_picklist_values SET sort_order_no=20 WHERE picklist_type_id=1397 AND picklist_value_cd='6057';
UPDATE cjams.tb_picklist_values SET sort_order_no=21 WHERE picklist_type_id=1397 AND picklist_value_cd='6058';
UPDATE cjams.tb_picklist_values SET sort_order_no=22 WHERE picklist_type_id=1397 AND picklist_value_cd='6059';

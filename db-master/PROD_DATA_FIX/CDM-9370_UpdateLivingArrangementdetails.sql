-- CDM-9370 - Add Primary caregiver and contact info

insert into livingarrangement 
(livingid ,livingarrangementtypekey,livingstartdate, livingenddate,primarycaregiver, streetname,cityname,countytypekey,statetypekey,zip5no,workphone,personid,insertedon,insertedby,updatedon,updatedby,placementid) 
(select gen_random_uuid(),'32944','2020-10-08 00:00:00','2020-12-04 00:00:00','Theresa Gorham','7017 Taylor Street','Hyattsville','1443','MD','20784','2406917002','a18ed7c5-1e6e-4449-acc3-dc41de52a1b8',now(),'CDM-9370',now(),'CDM-9370','c59fa513-40ff-43fb-ae92-2a5fa10a03c4');

insert into livingarrangement 
(livingid ,livingarrangementtypekey,livingstartdate, livingenddate,primarycaregiver, streetname,cityname,countytypekey,statetypekey,zip5no,workphone,personid,insertedon,insertedby,updatedon,updatedby,placementid) 
(select gen_random_uuid(),'32944','2020-12-04 15:00:00', null,'Theresa Gorham','383 Tayside Way','Hyattsville','1443','MD','20785','2406917002','a18ed7c5-1e6e-4449-acc3-dc41de52a1b8',now(),'CDM-9370',now(),'CDM-9370','3334e852-57c7-4b24-9cd0-d2952ca52ec9')

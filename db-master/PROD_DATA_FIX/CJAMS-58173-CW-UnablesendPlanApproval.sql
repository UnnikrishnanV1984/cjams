

/*
Issue Description: Please provide a data fix to create a new placement based on the below information
Category/Module: Support
Root cause: user could not abe to create a  placement
Fix provided: DB queries change  placement exit type
Data/Code fix ticket#:CJAMS-58173_1,CJAMS-58173_2
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query 
delete from placement where insertedby = 'CJAMS-58173_1';
delete from placementrevision where insertedby = 'CJAMS-58173_1';
delete from routing where insertedby = 'CJAMS-58173_1';
*/


--Delete 
delete from livingarrangement  where insertedby = 'CJAMS-58173_1';
delete from placementrevision where insertedby = 'CJAMS-58173_1';
delete from placement where insertedby = 'CJAMS-58173_1';
delete from routing where insertedby = 'CJAMS-58173_1';


--insert placement 202190031
insert into placement 
(placementid,intakeservicerequestactorid,startdatetime ,enddatetime ,
remarks,activeflag,effectivedate,insertedby,
insertedon,updatedby,updatedon,exitreasontypekey,
exittypekey,isvoided,intakeservreqchildremovalid,servicecaseid,
placementtypekey,service_id,starttime,endtime,
providersentdate,responseacceptedkey,isssaapproval,altproviderid,
personid,overunderflag,paymentheaderid,ratestructureid,
voidapprovaldate,primaryrelationship,leastrestrictiveplacement,ischildplacedoutside,
placementluggage,plluggagepurchased,exittime,placementstructureid)
values
(gen_random_uuid(),'1aeaa921-64ad-4d66-abd5-25400cc46463','2024-03-20 09:10:00',null,
null,1,'2024-03-20 09:10:00','CJAMS-58173_1',
now(),'CJAMS-58173_1',now(),null,
'PLCC',null,'1ca0f3d8-5c15-49f6-8d27-8c58fce5a56b','d3eba0bb-d843-4108-83a9-502e6a929ff6',
'PRPL',8,'09:10',null,
null,null,0,6184488,
'b7919de4-a1b9-435c-8121-f82a7de20585','0',null,null,
null,null,'Children are placed with their grandAunt',false,
null,null,null,null);

--insert placementrevision Review 202190031
insert into placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime,
approvalstatustypkey, isoriginal, insertedby, insertedon,
updatedby, updatedon, activeflag,  isvoided,
requestedby, requesteddate, approvedby, approvaldate,
approveddate, status,leastrestrictiveplacement, placementluggage, 
plluggagepurchased	,exitdate,exittime,enddate,
endtime,exittypekey)
values
(gen_random_uuid(), (select placementid from placement where insertedby = 'CJAMS-58173_1'),now(),'2024-03-20 00:00:00.000','00:00', 
'3045', 1,'CJAMS-58173_1', now(), 
'CJAMS-58173_1', now(),0,0,
'3f1b0b0a-e43a-4d2c-aea9-e50ab4662da5', now(),'832a15a1-1156-44c4-befa-0a4fc73460b5', now(),
now(),'Approved', 'Children are placed with their grandAunt.', null, 
true,'2024-12-20','00:00:00.000','2024-12-20',
'00:00:00','PLCC');

--insert placementrevision Approve 202190031
insert into placementrevision
(placementrevisionid, placementid, transactiondate, entrydate,entrytime,
approvalstatustypkey, isoriginal, insertedby, insertedon,
updatedby, updatedon, activeflag,  isvoided,
requestedby, requesteddate, approvedby, approvaldate,
approveddate, status,leastrestrictiveplacement, placementluggage, 
plluggagepurchased	,exitdate,exittime,enddate,endtime,exittypekey)
values
(gen_random_uuid(), (select placementid from placement where insertedby = 'CJAMS-58173_1'),now(),'2024-03-20 00:00:00.000','00:00', 
'3047', 1,'CJAMS-58173_1', now(), 
'CJAMS-58173_1', now(),1,0,
'3f1b0b0a-e43a-4d2c-aea9-e50ab4662da5',now(),'832a15a1-1156-44c4-befa-0a4fc73460b5', now(),
now(),'Approved', 'Children are placed with their grandAunt.', null, 
true ,'2024-12-20','00:00:00.000','2024-12-20',
'00:00:00','PLCC');


--insert routing Review 202190031
insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,
teamid,fromroleid,toroleid,
objectid,
routingstatustypeid,activeflag,insertedby,insertedon,
updatedby ,updatedon ,isreviewrequest,remarks,
routeddescription,servicerequestnumber,objecttypekey)
values
(gen_random_uuid(),'PLTR','832a15a1-1156-44c4-befa-0a4fc73460b5','3f1b0b0a-e43a-4d2c-aea9-e50ab4662da5',
'da6e89a1-82e1-46f7-a90e-d41a3987591d','CWCW',	'CWSP',
(select placementid   from placement where insertedby = 'CJAMS-58173_1')
,15,0,'CJAMS-58173_1',now(),'CJAMS-58173_1',
now(),true,null,null,
'231030226343','Servicecase');

--insert routing Approve 202190031
insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,
teamid,fromroleid,toroleid,
objectid,
routingstatustypeid,activeflag,insertedby,insertedon,
updatedby ,updatedon ,isreviewrequest,remarks,
routeddescription,servicerequestnumber,objecttypekey)
values
(gen_random_uuid(),'PLTR','832a15a1-1156-44c4-befa-0a4fc73460b5','3f1b0b0a-e43a-4d2c-aea9-e50ab4662da5',
'da6e89a1-82e1-46f7-a90e-d41a3987591d','CWSP',	'CWCW',
(select placementid   from placement where insertedby = 'CJAMS-58173_1')
,16,1,'CJAMS-58173_1',now(),'CJAMS-58173_1',
now(),true,null,null,
'231030226343','Servicecase');



delete from livingarrangement  where insertedby = 'CJAMS-58173_2';
delete from placementrevision where insertedby = 'CJAMS-58173_2';
delete from placement where insertedby = 'CJAMS-58173_2';
delete from routing where insertedby = 'CJAMS-58173_2';

--insert placement 202189997
insert into placement 
(placementid,intakeservicerequestactorid,startdatetime ,enddatetime ,
remarks,activeflag,effectivedate,insertedby,
insertedon,updatedby,updatedon,exitreasontypekey,
exittypekey,isvoided,intakeservreqchildremovalid,servicecaseid,
placementtypekey,service_id,starttime,endtime,
providersentdate,responseacceptedkey,isssaapproval,altproviderid,
personid,overunderflag,paymentheaderid,ratestructureid,
voidapprovaldate,primaryrelationship,leastrestrictiveplacement,ischildplacedoutside,
placementluggage,plluggagepurchased,exittime,placementstructureid)
values
(gen_random_uuid(),'4b9a6b6a-1c8d-4dee-836f-22f813fa7cf3','2024-03-20 09:10:00',null,
null,1,'2024-03-20 09:10:00','CJAMS-58173_2',
now(),'CJAMS-58173_2',now(),null,
'PLCC',null,'bdbc46dd-9433-4c3f-b89a-1ac09553729e','d3eba0bb-d843-4108-83a9-502e6a929ff6',
'PRPL',8,'09:10',null,
null,null,0,6184488,
'f1ac59a0-bf1c-42be-9dc3-f2356ff9908c','0',null,null,
null,null,'Children are placed with their grandAunt',false,
null,null,null,null);

--insert placementrevision Review 202189997
insert into placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime,
approvalstatustypkey, isoriginal, insertedby, insertedon,
updatedby, updatedon, activeflag,  isvoided,
requestedby, requesteddate, approvedby, approvaldate,
approveddate, status,leastrestrictiveplacement, placementluggage, 
plluggagepurchased	,exitdate,exittime,enddate,
endtime,exittypekey)
values
(gen_random_uuid(), (select placementid from placement where insertedby = 'CJAMS-58173_2'),now(),'2024-03-20 00:00:00.000','00:00', 
'3045', 1,'CJAMS-58173_2', now(), 
'CJAMS-58173_2', now(),0,0,
'3f1b0b0a-e43a-4d2c-aea9-e50ab4662da5', now(),'832a15a1-1156-44c4-befa-0a4fc73460b5', now(),
now(),'Approved', 'Children are placed with their grandAunt.', null, 
true,'2024-12-20','00:00:00.000','2024-12-20',
'00:00:00','PLCC');

--insert placementrevision Approve 202189997
insert into placementrevision
(placementrevisionid, placementid, transactiondate, entrydate,entrytime,
approvalstatustypkey, isoriginal, insertedby, insertedon,
updatedby, updatedon, activeflag,  isvoided,
requestedby, requesteddate, approvedby, approvaldate,
approveddate, status,leastrestrictiveplacement, placementluggage, 
plluggagepurchased	,exitdate,exittime,enddate,endtime,exittypekey)
values
(gen_random_uuid(), (select placementid from placement where insertedby = 'CJAMS-58173_2'),now(),'2024-03-20 00:00:00.000','00:00', 
'3047', 1,'CJAMS-58173_2', now(), 
'CJAMS-58173_2', now(),1,0,
'3f1b0b0a-e43a-4d2c-aea9-e50ab4662da5',now(),'832a15a1-1156-44c4-befa-0a4fc73460b5', now(),
now(),'Approved', 'Children are placed with their grandAunt.', null, 
true ,'2024-12-20','00:00:00.000','2024-12-20',
'00:00:00','PLCC');


--insert routing Review 202189997
insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,
teamid,fromroleid,toroleid,
objectid,
routingstatustypeid,activeflag,insertedby,insertedon,
updatedby ,updatedon ,isreviewrequest,remarks,
routeddescription,servicerequestnumber,objecttypekey)
values
(gen_random_uuid(),'PLTR','832a15a1-1156-44c4-befa-0a4fc73460b5','3f1b0b0a-e43a-4d2c-aea9-e50ab4662da5',
'da6e89a1-82e1-46f7-a90e-d41a3987591d','CWCW',	'CWSP',
(select placementid   from placement where insertedby = 'CJAMS-58173_2')
,15,0,'CJAMS-58173_2',now(),'CJAMS-58173_2',
now(),true,null,null,
'231030226343','Servicecase');

--insert routing Approve 202189997
insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,
teamid,fromroleid,toroleid,
objectid,
routingstatustypeid,activeflag,insertedby,insertedon,
updatedby ,updatedon ,isreviewrequest,remarks,
routeddescription,servicerequestnumber,objecttypekey)
values
(gen_random_uuid(),'PLTR','832a15a1-1156-44c4-befa-0a4fc73460b5','3f1b0b0a-e43a-4d2c-aea9-e50ab4662da5',
'da6e89a1-82e1-46f7-a90e-d41a3987591d','CWSP',	'CWCW',
(select placementid   from placement where insertedby = 'CJAMS-58173_2')
,16,1,'CJAMS-58173_2',now(),'CJAMS-58173_2',
now(),true,null,null,
'231030226343','Servicecase');
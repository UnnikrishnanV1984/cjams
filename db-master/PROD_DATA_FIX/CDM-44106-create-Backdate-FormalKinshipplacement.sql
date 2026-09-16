/*
Issue Description: Need data fix to create a placement with placement
structure as Formal Kinship Care with the detail information as mentioned below.
Category/Module: Support
Root cause: user could not abe to create a Backdate Formal Kinship placement
Fix provided: DB queries to create new record in routing  and placement table.
Data/Code fix ticket#: CDM-44106
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
delete from routing where insertedby = 'CDM-44106';
delete from placementrevision where insertedby = 'CDM-44106';
delete from livingarrangement where placementid = (select placementid from placement where insertedby = 'CDM-44106');
delete from placement where insertedby = 'CDM-44106';
*/
insert into placement 
(placementid,intakeservicerequestactorid ,startdatetime ,enddatetime ,remarks,activeflag,effectivedate,insertedby,insertedon,
updatedby,updatedon,exitreasontypekey,exittypekey,isvoided,intakeservreqchildremovalid,servicecaseid,placementtypekey,
service_id,starttime,endtime,providersentdate,responseacceptedkey,isssaapproval,altproviderid,personid,overunderflag,
paymentheaderid,ratestructureid,voidapprovaldate,primaryrelationship,leastrestrictiveplacement,ischildplacedoutside,
placementluggage,plluggagepurchased)
values
(gen_random_uuid(),'1f8754df-9576-4709-856b-4039be62a0dc','2024-03-22 13:00:00.000',null,null,1,'2024-03-22 13:00:00.000','CDM-44106',
now(),'CDM-44106',now(),null,null,null,'e9a5b1a7-7da2-4c02-bfd4-cac709556115','df44bdbd-98b9-4796-8f3f-14a44d6094ca','PRPL','8','13:00:00.000',null,'2024-03-22 13:00:00.000',
'4612',0,6166015,'42030303-f249-4528-b340-1a25cfafd3d0','0',null,null,null,'Non-Relative',
'The child is placed with fictive kin and has a relationship with the provider', true, false, false);

insert into placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, approvalstatustypkey, isoriginal, insertedby, insertedon,
updatedby, updatedon, activeflag, isvoided, requestedby, requesteddate, approvedby, approvaldate, approveddate, status,
leastrestrictiveplacement, placementluggage, plluggagepurchased)
values
(gen_random_uuid(), (select placementid from placement where insertedby  = 'CDM-44106'), '2024-03-22 13:00:00.000',
'2024-03-22 13:00:00.000','13:00', '3045', 1, 'CDM-44106', now(), 'CDM-44106', now(),0,0,
'94f06934-e3f2-43a7-bd06-22356c6f2e54', '2024-03-22 13:00:00.000', '0f21b527-afbb-4a4f-94b7-ce0ade354f99', null, '2024-03-22 13:00:00.000',
'Approved', 'The child is placed with fictive kin and has a relationship with the provider', false, false);

insert into placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, approvalstatustypkey, isoriginal, insertedby, insertedon,
updatedby, updatedon, activeflag, isvoided, requestedby, requesteddate, approvedby, approvaldate, approveddate, status,
leastrestrictiveplacement, placementluggage, plluggagepurchased)
values
(gen_random_uuid(), (select placementid from placement where insertedby  = 'CDM-44106'), '2024-03-22 13:00:00.000',
'2024-03-22 13:00:00.000','13:00', '3047', 1, 'CDM-44106', now(), 'CDM-44106', now(),1, 0,
'94f06934-e3f2-43a7-bd06-22356c6f2e54', '2024-03-22 13:00:00.000', '0f21b527-afbb-4a4f-94b7-ce0ade354f99','2024-03-22 13:00:00.000',
'2024-03-22 13:00:00.000', 'Approved', 'The child is placed with fictive kin and has a relationship with the provider', false, false);

insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,
activeflag,insertedby,insertedon,updatedby ,updatedon ,isreviewrequest,remarks,routeddescription,servicerequestnumber,objecttypekey)
values
(gen_random_uuid(),'PLTR','94f06934-e3f2-43a7-bd06-22356c6f2e54','0f21b527-afbb-4a4f-94b7-ce0ade354f99',
'0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc','CWCW',	'CWSP',(select placementid   from placement where insertedby  = 'CDM-44106')
,15,0,'CDM-44106',now(),'CDM-44106',now(),true,null,null,'241030279693','Servicecase');

insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,
activeflag,insertedby,insertedon,updatedby ,updatedon ,isreviewrequest,remarks,routeddescription,servicerequestnumber,objecttypekey)
values
(gen_random_uuid(),'PLTR','94f06934-e3f2-43a7-bd06-22356c6f2e54','0f21b527-afbb-4a4f-94b7-ce0ade354f99',
'0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc','CWCW', 'CWSP',(select placementid   from placement where insertedby  = 'CDM-44106')
,16,1,'CDM-44106',now(),'CDM-44106',now(),true,null,null,'241030279693','Servicecase');


insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,
activeflag,insertedby,insertedon,updatedby ,updatedon ,isreviewrequest,remarks,routeddescription,servicerequestnumber,objecttypekey)
values
(gen_random_uuid(),'PLTR','94f06934-e3f2-43a7-bd06-22356c6f2e54',null,
null,'CWCW', 'IVESV',(select placementid   from placement where insertedby  = 'CDM-44106')
,16,1,'CDM-44106',now(),'CDM-44106',now(),true,null,null,'241030279693','Servicecase');

update prov.tb_provider set vacancy_no = vacancy_no - 1, update_ts = now(), update_user_id = 'CDM-44106'
where provider_id = 6166015 and delete_sw = 'N' ;
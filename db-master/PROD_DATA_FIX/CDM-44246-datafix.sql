/*
  Issue Description:  CDM-44246
   Category/ Module  :  Placement
   Root cause: User requested to create new placement as we stopped Formal Kinship Care placement in system.
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/

insert into placement 
(placementid,intakeservicerequestactorid ,startdatetime ,enddatetime ,remarks,activeflag,effectivedate,insertedby,insertedon,
updatedby,updatedon,exitreasontypekey,exittypekey,isvoided,intakeservreqchildremovalid,servicecaseid,placementtypekey,
service_id,starttime,endtime,providersentdate,responseacceptedkey,isssaapproval,altproviderid,personid,overunderflag,
paymentheaderid,ratestructureid,voidapprovaldate,primaryrelationship,leastrestrictiveplacement,ischildplacedoutside,
placementluggage)
values
(gen_random_uuid(),'cd5a6559-da84-4324-9145-d7bf75ca757d','2024-11-01 08:01:00','2024-12-12 12:02:00',' Relative was provisionally licensed as a restrictive relative placement ahead of the new kinship structure that went into affect.',1,'2024-11-01 08:01:00','CDM-44246',
now(),'CDM-44246',now(),null,'CIPS',null,'539c1b42-7884-4ba7-9cf7-31181739fcc7','26469328-9362-4b68-a204-0d29c5489822','PRPL','9','08:01:00','12:02:00','2024-11-01 08:01:00',
'4612',0,6130271,'a14160bc-5543-415c-a4e4-c0c78796e9b9','0',null,null,null,'Non-Relative',
'Child is placed with relative caregiver', false, true);

insert into placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime,exitdate,exittime, approvalstatustypkey, isoriginal, insertedby, insertedon,
updatedby, updatedon, activeflag, isvoided, requestedby, requesteddate, approvedby, approvaldate, approveddate, status,
leastrestrictiveplacement, placementluggage)
values
(gen_random_uuid(), (select placementid from placement where insertedby  = 'CDM-44246'), '2024-11-01 08:01:00',
'2024-11-01 08:01:00','08:01','2024-12-12 12:02:00','12:02','3045', 1, 'CDM-44246', now(), 'CDM-44246', now(),0,0,
'0fc9bd71-88cf-4065-9446-df743c84293b', '2024-11-01 08:01:00', '1c34a2de-bca7-4651-8fcb-524d6c6e35fa', null, '2024-11-01 08:01:00',
'Approved', 'Child is placed with relative caregiver', true);

insert into placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime,exitdate,exittime,approvalstatustypkey, isoriginal, insertedby, insertedon,
updatedby, updatedon, activeflag, isvoided, requestedby, requesteddate, approvedby, approvaldate, approveddate, status,
leastrestrictiveplacement, placementluggage)
values
(gen_random_uuid(), (select placementid from placement where insertedby  = 'CDM-44246'), '2024-11-01 08:01:00',
'2024-03-22 13:00:00.000','13:00','2024-12-12 12:02:00','12:02', '3047', 1, 'CDM-44246', now(), 'CDM-44246', now(),1, 0,
'0fc9bd71-88cf-4065-9446-df743c84293b', '2024-11-01 08:01:00', '1c34a2de-bca7-4651-8fcb-524d6c6e35fa','2024-11-01 08:01:00',
'2024-11-01 08:01:00', 'Approved', 'Child is placed with relative caregiver',true );

insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,
activeflag,insertedby,insertedon,updatedby ,updatedon ,isreviewrequest,remarks,routeddescription,servicerequestnumber,objecttypekey)
values
(gen_random_uuid(),'PLTR','0fc9bd71-88cf-4065-9446-df743c84293b','1c34a2de-bca7-4651-8fcb-524d6c6e35fa',
'da6e89a1-82e1-46f7-a90e-d41a3987591d','CWCW',	'CWSP',(select placementid   from placement where insertedby  = 'CDM-44246')
,15,0,'CDM-44246',now(),'CDM-44246',now(),true,null,null,'3240139','Servicecase');

insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,
activeflag,insertedby,insertedon,updatedby ,updatedon ,isreviewrequest,remarks,routeddescription,servicerequestnumber,objecttypekey)
values
(gen_random_uuid(),'PLTR','0fc9bd71-88cf-4065-9446-df743c84293b','1c34a2de-bca7-4651-8fcb-524d6c6e35fa',
'da6e89a1-82e1-46f7-a90e-d41a3987591d','CWCW', 'CWSP',(select placementid   from placement where insertedby  = 'CDM-44246')
,16,1,'CDM-44246',now(),'CDM-44246',now(),true,null,null,'3240139','Servicecase');


insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,
activeflag,insertedby,insertedon,updatedby ,updatedon ,isreviewrequest,remarks,routeddescription,servicerequestnumber,objecttypekey)
values
(gen_random_uuid(),'PLTR','0fc9bd71-88cf-4065-9446-df743c84293b',null,
null,'CWCW', 'IVESV',(select placementid   from placement where insertedby  = 'CDM-44246')
,16,1,'CDM-44246',now(),'CDM-44246',now(),true,null,null,'3240139','Servicecase');

update prov.tb_provider set vacancy_no = vacancy_no - 1, update_ts = now(), update_user_id = 'CDM-44246'
where provider_id = 6130271 and delete_sw = 'N' ;

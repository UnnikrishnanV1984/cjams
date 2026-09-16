/*
   Issue Description: CJAMS-58608 Date Preventing Opening GAP
   Category/ Module  : Placement
   Root cause:Formal Kinship placement is removed from the system and we need a data fix to insert backdated formal kinship.
   Fix Provided: Received details from the user, need data fix for Formal Kinship Care Placement for the below clients,
    Case ID: 221030017773
    Client 1: CJAMS PID -  200950733   -   Spartan Alejandez-Jones  
    Client 2: CJAMS PID -   2000807702    -    Elijah Gregory  

   Pull request# 	N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Delete 
delete from placement where insertedby = 'CJAMS-58608';
delete from placementrevision where insertedby = 'CJAMS-58608';
delete from routing where insertedby = 'CJAMS-58608';

--Elijah Gregory  

insert into placement 
(placementid,intakeservicerequestactorid ,startdatetime ,enddatetime ,remarks,activeflag,effectivedate,insertedby,insertedon,
updatedby,updatedon,exittypekey,isvoided,intakeservreqchildremovalid,servicecaseid,placementtypekey,
service_id,starttime,endtime,providersentdate,responseacceptedkey,isssaapproval,altproviderid,personid,overunderflag,
paymentheaderid,ratestructureid,voidapprovaldate,primaryrelationship,leastrestrictiveplacement,ischildplacedoutside,
placementluggage)
values
(gen_random_uuid(),'ac9450e1-9f29-4d54-8cc1-b3860532a01d','2022-09-14 17:30:00','2024-12-12 08:00:00','',1,'2022-09-14 17:30:00','CJAMS-58608',
now(),'CJAMS-58608',now(),'CIPS',null,'dc2fa3f2-2bd9-4e4e-809c-323b69dc5466','48be6af9-2be8-434b-87fb-650824a28cc2','PRPL','8','17:30:00','08:00:00',now(),
'4612',0,6125234  ,'d42b02d5-d848-491e-b8a5-568c4deedc22','0',null,null,null,'','Child will be living with relatives.', false, true);

insert into placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime,exitdate,exittime, approvalstatustypkey, isoriginal, insertedby, insertedon,
updatedby, updatedon, activeflag, isvoided, requestedby, requesteddate, approvedby, approvaldate, approveddate, status,
leastrestrictiveplacement, placementluggage)
values
(gen_random_uuid(), (select placementid from placement where insertedby  = 'CJAMS-58608' and leastrestrictiveplacement = 'Child will be living with relatives.'), now() ,
'2022-09-14 17:30:00','18:00','2024-12-12 08:00:00','08:00','3045', 1, 'CJAMS-58608', now(), '8c64f736-8fe3-4ef6-b465-b1b931d733a3', now(),0,0,
'8c64f736-8fe3-4ef6-b465-b1b931d733a3', now() , '3ca8e63d-f885-445b-aab9-24456e91ad4a', null, now() ,
'Approved', '', true);

insert into placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime,exitdate,exittime,approvalstatustypkey, isoriginal, insertedby, insertedon,
updatedby, updatedon, activeflag, isvoided, requestedby, requesteddate, approvedby, approvaldate, approveddate, status,
leastrestrictiveplacement, placementluggage)
values
(gen_random_uuid(), (select placementid from placement where insertedby  = 'CJAMS-58608' and leastrestrictiveplacement = 'Child will be living with relatives.'), now() ,
'2022-09-14 17:30:00','18:00','2024-12-12 08:00:00','08:00', '3047', 1, 'CJAMS-58608', now(), '8c64f736-8fe3-4ef6-b465-b1b931d733a3', now(),1, 0,
'8c64f736-8fe3-4ef6-b465-b1b931d733a3', now(), '3ca8e63d-f885-445b-aab9-24456e91ad4a',null ,
now() , 'Approved', '',true );

insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,
activeflag,insertedby,insertedon,updatedby ,updatedon ,isreviewrequest,routeddescription,servicerequestnumber,objecttypekey)
values
(gen_random_uuid(),'PLTR','8c64f736-8fe3-4ef6-b465-b1b931d733a3','3ca8e63d-f885-445b-aab9-24456e91ad4a',
'6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6','CWCW',	'CWSP',(select placementid from placement where insertedby  = 'CJAMS-58608' and leastrestrictiveplacement = 'Child will be living with relatives.')
,15,0,'CJAMS-58608',now(),'8c64f736-8fe3-4ef6-b465-b1b931d733a3',now(),true,null,'221030017773','Servicecase');

insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,
activeflag,insertedby,insertedon,updatedby ,updatedon ,isreviewrequest,routeddescription,servicerequestnumber,objecttypekey)
values
(gen_random_uuid(),'PLTR','8c64f736-8fe3-4ef6-b465-b1b931d733a3','3ca8e63d-f885-445b-aab9-24456e91ad4a',
'6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6','CWCW', 'CWSP',(select placementid from placement where insertedby  = 'CJAMS-58608' and leastrestrictiveplacement = 'Child will be living with relatives.')
,16,1,'CJAMS-58608',now(),'8c64f736-8fe3-4ef6-b465-b1b931d733a3',now(),true,null,'221030017773','Servicecase');


insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,
activeflag,insertedby,insertedon,updatedby ,updatedon ,isreviewrequest,remarks,routeddescription,servicerequestnumber,objecttypekey)
values
(gen_random_uuid(),'PLTR','8c64f736-8fe3-4ef6-b465-b1b931d733a3',null,
null,'CWCW', 'IVESV',(select placementid from placement where insertedby  = 'CJAMS-58608' and leastrestrictiveplacement = 'Child will be living with relatives.')
,16,1,'CJAMS-58608',now(),'CJAMS-58608',now(),true,null,null,'221030017773','Servicecase');

update prov.tb_provider set vacancy_no = vacancy_no - 1, update_ts = now(), update_user_id = 'CJAMS-58608'
where provider_id = 6125234  and delete_sw = 'N' ;

--Spartan Alejandez-Jones 

INSERT INTO cjams.placement 
        (placementid            ,intakeservicerequestactorid           , startdatetime,enddatetime,  remarks, activeflag, effectivedate, insertedby                               , insertedon, updatedby , updatedon,exitreasontypekey,exittypekey,intakeservreqchildremovalid              , servicecaseid                          ,placementtypekey, service_id,  starttime,endtime,  providersentdate,  responseacceptedkey, rejectreasonkey, isssaapproval,  altproviderid,  personid                                , ratestructureid,  primaryrelationship, leastrestrictiveplacement                                                , placementluggage)
values    (cjams.gen_random_uuid(),'a280d4c8-f68d-4d57-bb99-2acc9deabb48', '2022-09-09' , '2024-12-12',''        , 1            ,'2022-09-09'  , '8c64f736-8fe3-4ef6-b465-b1b931d733a3',  now()     ,'CJAMS-58608', now()       ,NULL,'CIPS','e79e9cdd-f9f2-4c65-aae8-1d17c8452279', '48be6af9-2be8-434b-87fb-650824a28cc2','PRPL'           ,'8          ','18:00'   ,'08:00', 'now()             ', '4612'                , 'null'         , '0'            ,  '6125234'    , '22dda7ca-9073-4f80-8e5e-29db222e8b3a', null             , ''                     , 'Child will be living with relatives', 'true'          );

-- Placement Revision
INSERT INTO cjams.placementrevision
       (placementrevisionid      , placementid, transactiondate, entrydate, entrytime,exitdate,exittime, approvalstatustypkey, isoriginal, insertedon, insertedby                            , updatedon, updatedby                                , activeflag,alternateid,  isvoided,  requestedby                           ,requesteddate,approvedby                            ,approveddate, status, leastrestrictiveplacement                                              ,  placementluggage)
select cjams.gen_random_uuid(), placementid, now()              , '2022-09-09'    , '18:00'    ,'2024-12-12','08:00', '3045'                , 1              , now()   , '8c64f736-8fe3-4ef6-b465-b1b931d733a3', now()       , '8c64f736-8fe3-4ef6-b465-b1b931d733a3'    , 0            , '6125234'    ,  0       , '8c64f736-8fe3-4ef6-b465-b1b931d733a3', now()          ,'3ca8e63d-f885-445b-aab9-24456e91ad4a',now()         ,'Approved', '', 'true'
    from cjams.placement where updatedby = 'CJAMS-58608' and leastrestrictiveplacement = 'Child will be living with relatives' order by updatedon desc limit 1;

INSERT INTO cjams.placementrevision
       (placementrevisionid      , placementid, transactiondate, entrydate, entrytime,exitdate,exittime, approvalstatustypkey, isoriginal, insertedon, insertedby                            , updatedon, updatedby                                , activeflag,alternateid,  isvoided,  requestedby                           , requesteddate,approvedby                            ,approveddate,  status, leastrestrictiveplacement                                              ,  placementluggage)
select cjams.gen_random_uuid(), placementid, now()              , '2022-09-09'    , '18:00'    ,'2024-12-12','08:00','3047'                , 1              , now()   , '8c64f736-8fe3-4ef6-b465-b1b931d733a3', now()       , '8c64f736-8fe3-4ef6-b465-b1b931d733a3'    , 1            , '6125234'    ,  0       , '8c64f736-8fe3-4ef6-b465-b1b931d733a3', now()          ,'3ca8e63d-f885-445b-aab9-24456e91ad4a',now()         ,'Approved', '', 'true'
    from cjams.placement where updatedby = 'CJAMS-58608' and leastrestrictiveplacement = 'Child will be living with relatives' order by updatedon desc limit 1;

-- Routing Insert

INSERT INTO cjams.routing
         (routingid               ,eventcode, fromsecurityusersid                     , tosecurityusersid                     , teamid                                 , fromroleid, toroleid, objectid    , routingstatustypeid, activeflag, insertedby                             , insertedon, updatedby                             , updatedon, isreviewrequest,  routeddescription                           , servicerequestnumber)
select  cjams.gen_random_uuid(), 'PLTR'     , '8c64f736-8fe3-4ef6-b465-b1b931d733a3', '3ca8e63d-f885-445b-aab9-24456e91ad4a::uuid', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWCW'       , 'CWSP'  , placementid, 15                 , 0           , '8c64f736-8fe3-4ef6-b465-b1b931d733a3', now()     , '8c64f736-8fe3-4ef6-b465-b1b931d733a3', now()    , true              , 'Provider placement submitted for review', '221030017773'
    from cjams.placement where updatedby = 'CJAMS-58608' and leastrestrictiveplacement = 'Child will be living with relatives' order by updatedon desc limit 1;

INSERT INTO cjams.routing
         (routingid               ,eventcode, fromsecurityusersid                     , tosecurityusersid                     , teamid                                 , fromroleid, toroleid, objectid    , routingstatustypeid, activeflag, insertedby                             , insertedon, updatedby                             , updatedon, isreviewrequest,  routeddescription                           , servicerequestnumber)
select  cjams.gen_random_uuid(), 'PLTR'     , '8c64f736-8fe3-4ef6-b465-b1b931d733a3', '3ca8e63d-f885-445b-aab9-24456e91ad4a', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWCW'       , 'CWSP'  , placementid, 16                 , 1           , '8c64f736-8fe3-4ef6-b465-b1b931d733a3', now()     , '8c64f736-8fe3-4ef6-b465-b1b931d733a3', now()    , true              , 'Child PlacementApproved'                , '221030017773'
    from cjams.placement where updatedby = 'CJAMS-58608' and leastrestrictiveplacement = 'Child will be living with relatives' order by updatedon desc limit 1;

INSERT INTO cjams.routing
         (routingid               ,eventcode, fromsecurityusersid                     , tosecurityusersid, teamid, fromroleid, toroleid, objectid    , routingstatustypeid, activeflag, insertedby                             , insertedon, updatedby                             , updatedon, isreviewrequest,  routeddescription, servicerequestnumber)
select  cjams.gen_random_uuid(), 'PLTR'     , '8c64f736-8fe3-4ef6-b465-b1b931d733a3', null                , null    , 'CWCW'       , 'IVESV', placementid , 16                 , 1           , '8c64f736-8fe3-4ef6-b465-b1b931d733a3', now()     , '8c64f736-8fe3-4ef6-b465-b1b931d733a3', now()    , null              , ''                 , '221030017773'
    from cjams.placement where updatedby = 'CJAMS-58608' and leastrestrictiveplacement = 'Child will be living with relatives' order by updatedon desc limit 1;

-------

update prov.tb_provider set vacancy_no = vacancy_no - 1, update_ts = now(), update_user_id = 'CJAMS-58608'
where provider_id = 6125234  and delete_sw = 'N' ;


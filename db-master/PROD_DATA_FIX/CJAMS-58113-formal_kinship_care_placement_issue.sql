/* 
    Issue Description: CJAMS-58113
   Category/ Module  : Placement
   Root cause: User requested add placement record
   Pull request# for code fix: 
   Reason why no related code fix: Formal Kinship Care is not supported in system
*/

INSERT INTO cjams.placement 
	(placementid ,intakeservicerequestactorid , startdatetime, remarks , activeflag, effectivedate, insertedby , insertedon, updatedby , updatedon,intakeservreqchildremovalid , servicecaseid ,placementtypekey, service_id, starttime, providersentdate, responseacceptedkey, rejectreasonkey, isssaapproval, altproviderid, personid , ratestructureid, primaryrelationship, leastrestrictiveplacement , placementluggage) 
values (cjams.gen_random_uuid(),'9a0a1a85-0868-4459-b426-bb37e8b54c15', '2024-06-26' , null, 1 ,'2024-06-26' , '95e6c82b-912c-4d89-81a9-078d920c3b97', now() ,'CJAMS-58113', now() ,'4d646e5d-7455-4b59-a138-74db3acfad2d', 'b2fd5583-1e7a-4b53-8617-53b3eacda19f','PRPL' ,'8 ','07:00' , now(), '4612' , null , '0' , '6169309' , 'a71f7f0c-92e5-47aa-b734-ad93c9394401', null , '' , 'This placement is the least restrictive as Brandon will be placed with his grandfather', 'true' );

-- Placement Revision

INSERT INTO cjams.placementrevision 
	(placementrevisionid , placementid, transactiondate, entrydate, entrytime, approvalstatustypkey, isoriginal, insertedon, insertedby , updatedon, updatedby , activeflag,alternateid, remarks, isvoided, requestedby ,requesteddate,approvedby ,approveddate, status, leastrestrictiveplacement , placementluggage) 
select cjams.gen_random_uuid(), placementid, now() , '2024-06-26' , '07:00' , 3047 , 1 , now() , '95e6c82b-912c-4d89-81a9-078d920c3b97', now() , '95e6c82b-912c-4d89-81a9-078d920c3b97' , 0 , '6175707' , '' , 0 , '95e6c82b-912c-4d89-81a9-078d920c3b97', now() ,'0f21b527-afbb-4a4f-94b7-ce0ade354f99',now() ,'Review', 'This placement is the least restrictive as Brandon will be placed with his grandfather.', 'true' 
from cjams.placement where updatedby = 'CJAMS-58113' order by updatedon desc limit 1; 

INSERT INTO cjams.placementrevision 
	(placementrevisionid , placementid, transactiondate, entrydate, entrytime, approvalstatustypkey, isoriginal, insertedon, insertedby , updatedon, updatedby , activeflag,alternateid, remarks, isvoided, requestedby , requesteddate,approvedby ,approveddate, status, leastrestrictiveplacement , placementluggage) 
select cjams.gen_random_uuid(), placementid, now() ,'2024-06-26' , '07:00' , 3045 , 1 , now() , '95e6c82b-912c-4d89-81a9-078d920c3b97', now() , '95e6c82b-912c-4d89-81a9-078d920c3b97' , 1 , '6175707' , '' , 0 , '95e6c82b-912c-4d89-81a9-078d920c3b97', now() ,'0f21b527-afbb-4a4f-94b7-ce0ade354f99',now() ,'Approved', 'This placement is the least restrictive as Brandon will be placed with his grandfather', 'true' 
from cjams.placement where updatedby = 'CJAMS-58113' order by updatedon desc limit 1;

-- Routing Insert

INSERT INTO cjams.routing (routingid ,eventcode, fromsecurityusersid , tosecurityusersid , teamid , fromroleid, toroleid, objectid , routingstatustypeid, activeflag, insertedby , insertedon, updatedby , updatedon, isreviewrequest, routeddescription , servicerequestnumber,objecttypekey) 
	select cjams.gen_random_uuid(), 'PLTR' , '95e6c82b-912c-4d89-81a9-078d920c3b97::uuid', '0f21b527-afbb-4a4f-94b7-ce0ade354f99::uuid', '0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc', 'CWCW' , 'CWSP' , placementid, 15 , 0 , '95e6c82b-912c-4d89-81a9-078d920c3b97', now() , 'fa6c7906-97af-4f35-8987-dbc6add7090d', now() , true , 'Provider placement submitted for review', '3259656','Servicecase' 
from cjams.placement where updatedby = 'CJAMS-58113' order by updatedon desc limit 1; 

INSERT INTO cjams.routing (routingid ,eventcode, fromsecurityusersid , tosecurityusersid , teamid , fromroleid, toroleid, objectid , routingstatustypeid, activeflag, insertedby , insertedon, updatedby , updatedon, isreviewrequest, routeddescription , servicerequestnumber,objecttypekey) 
	select cjams.gen_random_uuid(), 'PLTR' , '95e6c82b-912c-4d89-81a9-078d920c3b97', '0f21b527-afbb-4a4f-94b7-ce0ade354f99', '0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc', 'CWCW' , 'CWSP' , placementid, 16 , 1 , '95e6c82b-912c-4d89-81a9-078d920c3b97', now() , '95e6c82b-912c-4d89-81a9-078d920c3b97', now() , true , 'Child PlacementApproved' , '3259656','Servicecase' 
from cjams.placement where updatedby = 'CJAMS-58113' order by updatedon desc limit 1; 

INSERT INTO cjams.routing (routingid ,eventcode, fromsecurityusersid , tosecurityusersid, teamid, fromroleid, toroleid, objectid , routingstatustypeid, activeflag, insertedby , insertedon, updatedby , updatedon, isreviewrequest, routeddescription, servicerequestnumber,objecttypekey) 
select cjams.gen_random_uuid(), 'PLTR' , '95e6c82b-912c-4d89-81a9-078d920c3b97', null , null , 'CWCW' , 'IVESV', placementid , 16 , 1 , '95e6c82b-912c-4d89-81a9-078d920c3b97::uuid', now() , '95e6c82b-912c-4d89-81a9-078d920c3b97::uuid', now() , null , '' , '3259656','Servicecase' 
from cjams.placement where updatedby = 'CJAMS-58113' order by updatedon desc limit 1;


-- tb_provider update
update prov.tb_provider set vacancy_no = vacancy_no - 1, update_ts = now(), update_user_id = 'CJAMS-58113'
where provider_id = 6169309 and delete_sw = 'N' ;




